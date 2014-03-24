Q = require 'q'
rest = require 'restler'

class Trello
  initialize: ->
    # Specific config file for this plugin
    config = require "./config"

    @trello = config.trello
    @projects = config.projects
    @getConfig()


  action: (@payload)->
    return unless @payload.commits? and @checkValidity()
    projectName = @payload.repository.name
    commits = @payload.commits
    board = @getBoard(projectName)
    testListId = @getListId('done', board)
    return unless board
    @getCards(board.id).then (cards)=>
      for commit in commits
        cardId = @getCardId(cards, commit)
        continue unless cardId
        @commentCard(cardId, commit)
        continue if @parseMove(commit) and testListId
        @moveCard(cardId, testListId)


  # Get lists and members for all projects in config
  getConfig: ->
    @projects.forEach (project) =>
      url = @getUrl('lists', project.boardId)
      rest.get(url).on 'complete', (data)->
        project.lists = data.lists
        project.members = data.members


  getUrl: (type, id) ->
    url = @trello.urls[type]
    url.replace(':api', @trello.api)
      .replace(':id', id)
      .replace(':key', @trello.key)
      .replace(':token', @trello.token)


  checkValidity: ->
    @payload.ref.indexOf('master') > 0


  # Get all cards for a board
  getCards: (boardId) ->
    url = @getUrl('cards', boardId)
    defer = Q.defer()
    rest.get(url).on 'complete', (data) ->
      defer.resolve data
    defer.promise


  # Retrieve card id from commit message
  getCardId: (cards, commit) ->
    id = commit.message.match(/#([0-9]+)/)
    return unless id
    id = parseInt(id[1], 10)
    for card in cards
      return card.shortLink if card.idShort is id


  # Post comment on trello card with commit link
  commentCard: (cardId, commit) ->
    url = @getUrl('card', cardId)
    msg = "#{commit.committer.username}: #{commit.url}"
    rest.post(url,
      data:
        text: msg
    )


  # Retrieve board using its name
  getBoard: (name)->
    for project in @projects
      return project if name.toLowerCase() is project.name.toLowerCase()


  #
  getListId: (name, board)->
    for list in board.lists
      return list.id if name.toLowerCase() is list.name.toLowerCase()


  parseMove: (commit)->
    commit.message.match(/fix|fixes|close|closes +#[0-9]+/)


  # Post to move card to test list
  moveCard: (cardId, testListId) ->
    url = @getUrl('moveCard', cardId)
    rest.put(url,
      data:
        idList: testListId
    )

module.exports = Trello
