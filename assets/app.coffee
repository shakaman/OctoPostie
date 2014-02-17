#= require config

rest    = require 'restler'
express = require 'express'
_       = require 'lodash'

app = express()
app.use express.json()
app.use express.urlencoded()

app.post '/', (req, res) ->
  res.send {}
  payload = JSON.parse req.body?.payload
  if payload
    project = projects.where github: payload.repository.name
    commits = new Commits payload.commits
    cards = project.board.cards
    cards.fetch().on 'complete', =>
      for commit in commits.map()
        _.each cards.where
          idShort: commit.parseTrelloCard()
        , (card)-> card.addComment commit.url

projects = new Projects config.projects

class Projects
  constructor: (projects)->
    @_projects = for project in projects
      new Project project
  where: (opts)->
    _(@_projects).where opts

class Project
  constructor: (data)->
    extends @, data
    @board = new Board id: data.trello

class Commits
  constructor: (commits)->
    @_commits = for commit in commits
      new Commit commit
  map: (fn)->
    _.map @_commits, fn

class Commit
  constructor: (data)->
    extends @, data

  _trelloCard: /#([0-9]+)/
  parseTrelloCard: ->
    num = @message.match @_trelloCard
    return unless num
    parseInt num[1], 10

class Board
  constructor: (data)->
    extends @, data
    @cards = new Cards board: @

class Cards
  constructor: (opts)->
    _.extends @, opts

  url: ->
    "#{config.trello.api}/boards/#{@board.id}/cards/?key=#{config.trello.key}&token=#{config.trello.token}"

  fetch: ->
    p = rest.get @url()
    p.on 'complete', (cards) =>
      @_cards = for card in cards
        new Card card

      parseCommit commit for commit in @commits

class Card
  constructor: (data)->
    extends @, data
  addComment: (msg) ->
    url = "#{config.trello.api}/cards/#{@card.shortLink}/actions/comments?key=#{config.trello.key}&token=#{config.trello.token}"
    rest.post(url,
      data:
        text: msg
    ).on 'complete', (data, response) ->
      console.log '200 ok' if (response.statusCode == 201)


app.listen 4567, ->
  console.log 'Listening on port 4567'

