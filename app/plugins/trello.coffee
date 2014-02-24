Q = require 'q'
rest = require 'restler'

initialize = ->
  @projects = config.projects
  @trello = config.trello
  getConfig()


# Get lists and members for all projects in config
getConfig = ->
  for project, i in @projects
    urlLists = "#{@trello.api}/boards/#{project.boardId}?members=all&lists=all&key=#{@trello.key}&token=#{@trello.token}"
    rest.get(urlLists).on 'complete', do (i) -> (data)=>
      @projects[i].lists = data.lists
      @projects[i].members = data.members


action = (payload)->
  if payload.commits? # and checkValidity()
    projectName = payload.repository.name
    commits = payload.commits
    boardId = getBoardId(projectName)
    return unless boardId
    getCards(boardId).then (cards)->
      for commit in commits
        cardId = getCardId(cards, commit)
        continue unless cardId
        commentCard(cardId, commit)


# Get all cards for a board
getCards = (boardId) ->
  url = "#{@trello.api}/boards/#{boardId}/cards/?fields=idShort,shortLink&key=#{@trello.key}&token=#{@trello.token}"
  defer = Q.defer()
  rest.get(url).on 'complete', (data) =>
    defer.resolve data
  defer.promise


# Retrieve card id from commit message
getCardId = (cards, commit) ->
  id = commit.message.match(/#([0-9]+)/)
  return unless id
  id = parseInt(id[1], 10)
  for card in cards
    return card.shortLink if card.idShort is id


# Post comment on trello card with commit link
commentCard = (cardId, commit) ->
  url = "#{@trello.api}/cards/#{cardId}/actions/comments?key=#{@trello.key}&token=#{@trello.token}"
  msg = "#{commit.committer.username}: #{commit.url}"
  rest.post(url,
    data:
      text: msg
  )

# Retrieve board id using its name
getBoardId = (name)->
  for project in @projects
    return project.boardId if name is project.name

