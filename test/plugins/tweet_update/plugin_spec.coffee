chai = require 'chai'
sinon = require 'sinon'
sinonChai = require 'sinon-chai'
chai.should()
chai.use(sinonChai)
expect = require 'expect.js'
nock = require 'nock'

proxyquire = require('proxyquire').noCallThru()

config = require './config'


describe 'Plugin TweetUpdate', ->
  beforeEach ->
    nock.disableNetConnect()
    @TweetUpdate = new (proxyquire('../../../dist/plugins/tweet_update/plugin',
      './config': config
    ))()
    @TweetUpdate.initialize()

  afterEach ->
    nock.enableNetConnect()
    nock.cleanAll()


  it 'Should initialize when required', ->

  describe 'hasTag', ->
    it "Should return false if payload does't contain tag", ->
      @TweetUpdate.payload =
        ref: "refs/heads/master"
      @TweetUpdate.hasTag().should.be.false

    it "Should return true if payload contain tag", ->
      @TweetUpdate.payload =
        ref: "refs/tags/2.0.2"
      @TweetUpdate.hasTag().should.be.true


  describe 'tagIsValid', ->
    it "Should return false if tag is not match", ->
      @TweetUpdate.payload =
        ref: "refs/tags/new-version"
      @TweetUpdate.tagIsValid().should.be.false

    it "Should return true if tag match 2.0.2", ->
      @TweetUpdate.payload =
        ref: "refs/tags/2.0.2"
      @TweetUpdate.tagIsValid().should.be.true

    it "Should return true if tag match v2.0.2", ->
      @TweetUpdate.payload =
        ref: "refs/tags/v2.0.2"
      @TweetUpdate.tagIsValid().should.be.true


  describe 'isPrivate', ->
    it 'Should return false if project is not private', ->
      @TweetUpdate.payload =
        repository:
          private: false
      @TweetUpdate.isPrivate().should.be.false

    it 'Should return true if project is private', ->
      @TweetUpdate.payload =
        repository:
          private: true
      @TweetUpdate.isPrivate().should.be.true

