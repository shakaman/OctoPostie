Q = require 'q'
rest = require 'restler'


class Trello
  initialize: ->
    # Specific config file for this plugin
    config = require "#{__dirname}/config"

    @trello = config.trello
    @projects = config.projects
    @getConfig()


  action: (payload)->
    if payload.commits? # and checkValidity()
      projectName = payload.repository.name
      commits = payload.commits
      boardId = @getBoardId(projectName)
      return unless boardId
      @getCards(boardId).then (cards)=>
        for commit in commits
          cardId = @getCardId(cards, commit)
          continue unless cardId
          @commentCard(cardId, commit)


  # Get lists and members for all projects in config
  getConfig: ->
    for project, i in @projects
      url = @getUrl('lists', project.boardId)
      rest.get(url).on 'complete', do (i, @projects)-> (data)=>
        @projects[i].lists = data.lists
        @projects[i].members = data.members


  getUrl: (type, id) ->
    url = @trello.urls[type]
    url.replace(':api', @trello.api)
      .replace(':id', id)
      .replace(':key', @trello.key)
      .replace(':token', @trello.token)

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


  # Retrieve board id using its name
  getBoardId: (name)->
    for project in @projects
      return project.boardId if name is project.name


module.exports = Trello
