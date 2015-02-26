rest = require 'restler'

class Trello
  initialize: ->
    # Specific config file for this plugin
    config = require "./config"

    @projects = config.projects
    @trelloConfig = config.trello
    @githubConfig = config.github
    @getConfig()


  action: (@payload, cb)->
    projectName = @payload.repository.name
    commits = @payload.commits
    board = @getBoard(projectName)
    testListId = @getListId('test', board)
    return unless board
    @getCards board.boardId, (err, cards)=>
      return cb(err) if err
      for commit in commits
        cardId = @getCardId(cards, commit)
        continue unless cardId
        @commentCard(cardId, commit)
        continue unless @parseMove(commit) and testListId
        @moveCard(cardId, testListId)
      cb()


  # get lists and members for all projects in config
  getConfig: ->
    @projects.forEach (project) =>
      url = @getUrl('lists', project.boardId)
      rest.get(url).on 'complete', (data)->
        project.lists = data.lists
        project.members = data.members


  getUrl: (type, id) ->
    url = @trelloConfig.urls[type]
    url.replace(':api', @trelloConfig.api)
      .replace(':id', id)
      .replace(':key', @trelloConfig.key)
      .replace(':token', @trelloConfig.token)

  isConcernBy: (payload)->
    payload.commits? and payload.ref.indexOf('master') > 0


  # get all cards for a board
  getCards: (boardId, cb) ->
    url = @getUrl('cards', boardId)
    rest.get(url).on 'complete', (data)->
      return cb data if data instanceof Error
      cb null, data


  # Retrieve card id from commit message
  getCardId: (cards, commit) ->
    id = commit.message.match(/#([0-9]+)/)
    return unless id
    return if commit.message.indexOf("Merge pull request ##{id} ") != -1
    id = parseInt(id[1], 10)
    for card in cards
      return card.shortLink if card.idShort is id


  # Post comment on trello card with commit link
  commentCard: (cardId, commit) ->
    url = @getUrl('card', cardId)
    msg = "#{commit.committer.username}: #{commit.message} #{commit.url}"
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
    commit.message.match(/fix|fixes|close|closes +#[0-9]+/i)


  # Post to move card to test list
  moveCard: (cardId, testListId)->
    url = @getUrl('moveCard', cardId)
    rest.put(url,
      data:
        idList: testListId
    )


  # Load readme from github
  loadReadme: (commit)->
    url = "#{@githubConfig.api}/#{commit.repository.owner.name}/#{commit.repository.name}/readme"
    rest.get(url,
      data:
        access_token: @githubConfig.token
    ).on 'complete', (data)->
      content = new Buffer(data.content, data.encoding)
      @searchTrelloUrl(content.toString(), commit.repository.name)


  # Search trello url
  searchTrelloUrl: (content, name)->
    url = content.match(/https:\/\/trello\.com\/b\/([0-9a-f]+)\//i)
    return unless url
    project =
      name: name
      boardId: url[1]
    @projects.push project
    @getconfig()


module.exports = Trello
