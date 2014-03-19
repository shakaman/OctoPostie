chai = require 'chai'
sinon = require 'sinon'
sinonChai = require 'sinon-chai'
chai.should()
chai.use(sinonChai)
expect = require 'expect.js'
nock = require 'nock'

proxyquire = require('proxyquire').noCallThru()

config = require './config'
mock = require './mock'
payload = require '../../payload'

describe 'Plugin Trello', ->
  beforeEach ->
    nock.disableNetConnect()
    @trello = new (proxyquire('../../../dist/plugins/trello/plugin',
      './config': config
    ))()
    @trelloList = nock('http://api.trello.com')
      .filteringPath (path)->
        '/1/boards'
      .get('/1/boards')
      .reply(200, mock.boards[0])
      .get('/1/boards')
      .reply(200, mock.boards[1])

  afterEach ->
    nock.enableNetConnect()
    nock.cleanAll()

  it 'Should initialize when required', ->


  describe 'initialize', ->
    beforeEach ->
      @configSpy = sinon.spy @trello, 'getConfig'
      @trello.initialize()

    afterEach ->
      @configSpy.restore()

    it 'Should call getConfig when initializing', ->
      @configSpy.should.have.been.calledOnce


  describe 'checkValidity', ->
    it "Should return false when payload doesn't contain master", ->
      @trello.payload =
        ref: 'refs/heads/prod'
      @trello.checkValidity().should.not.be.true

    it "Should return true when payload contain master", ->
      @trello.payload =
        ref: 'refs/heads/master'
      @trello.checkValidity().should.be.true


  describe 'getConfig', ->
    it 'Call trello api for each project', ->
      @trello.initialize()
      @trello.projects.should.have.length(2)
      @trello.projects[0].lists.should.have.length(3)
      @trello.projects[0].lists[0].id.should.be.equal('listtodoboard1')
      @trello.projects[1].lists[0].id.should.be.equal('listtodoboard2')


  describe 'getUrl', ->
    beforeEach ->
      @getUrlSpy = sinon.spy @trello, 'getUrl'
      @trello.initialize()

    afterEach ->
      @getUrlSpy.restore()

    it 'Should call getUrl for each project', ->
      @getUrlSpy.should.have.been.callCount @trello.projects.length

    it 'Should return list url', ->
      url = 'http://api.trello.com/1/boards/boardId1?members=all&lists=all&key=123456789&token=123456789'
      @trello.getUrl('lists', 'boardId1').should.be.equal(url)

    it 'Should return cards url', ->
      url = 'http://api.trello.com/1/boards/boardId1/cards/?fields=idShort,shortLink&key=123456789&token=123456789'
      @trello.getUrl('cards', 'boardId1').should.be.equal(url)

    it 'Should return card url', ->
      url = 'http://api.trello.com/1/cards/cardId1/actions/comments?key=123456789&token=123456789'
      @trello.getUrl('card', 'cardId1').should.be.equal(url)


  describe 'getBoardId', ->
    beforeEach ->
      @trello.initialize()

    it 'Should have good project when i call getBoardId with a name', ->
      @trello.getBoardId('project1').should.be.equal('boardId1')


  describe 'getCards', ->
    beforeEach (done)->
      @trelloCards = nock('http://api.trello.com')
        .filteringPath (path)->
          '/1/cards'
        .get('/1/cards')
        .reply(200, mock.cards)
      @trello.initialize()
      @promise = @trello.getCards('boardId1').then (cards)=>
        @cards = cards
        done()

    it 'Should have 8 cards when i call getCards', ->
      @cards.should.have.length(8)


  describe 'getCardId', ->
    beforeEach ->
      @trello.initialize()

    it 'Should have a good cardId for a specific commit', ->
      @trello.getCardId(mock.cards, payload.commits[1]).should.be.equal('EHm8BHxh')

    it "Should return undefined if commit message doesn't have reference to card", ->
      expect(@trello.getCardId(mock.cards, payload.commits[0])).to.be.undefined


  describe 'action', ->
    beforeEach (done)->
      @commentCardSpy = sinon.spy @trello, 'commentCard'
      @trelloCards = nock('http://api.trello.com')
        .filteringPath (path)->
          '/1/cards'
        .get('/1/cards')
        .reply(200, mock.cards)
        .post('/1/cards',
          text: 'shakaman: https://github.com/shakaman/OctoPostie/commit/2c2fc2453a785328833d573f838881dd599cdc5c'
        )
        .reply(200)
      @trello.initialize()
      @trello.action(payload).then ->
        done()

    afterEach ->
      @commentCardSpy.restore()

    it 'Should call once commentCard', ->
      @commentCardSpy.should.have.been.calledOnce
