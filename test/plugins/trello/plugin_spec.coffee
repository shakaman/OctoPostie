chai = require 'chai'
sinon = require 'sinon'
sinonChai = require 'sinon-chai'
chai.should()
chai.use(sinonChai)
nock = require 'nock'

proxyquire = require('proxyquire').noCallThru()

config = require './config'
mock = require './mock'

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
      .reply(200, mock[0])
      .get('/1/boards')
      .reply(200, mock[1])

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
      @trello.projects.length.should.be.equal(2)
      @trello.projects[0].lists.length.should.be.equal(3)
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



  describe 'action', ->
    it 'action'
  describe 'getCards', ->
    it 'getCards'
  describe 'getCardId', ->
    it 'getCardId'
  describe 'commentCard', ->
    it 'commentCard'
