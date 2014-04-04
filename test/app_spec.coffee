chai = require 'chai'
sinon = require 'sinon'
sinonChai = require 'sinon-chai'
should = chai.should()
chai.use(sinonChai)

request = require 'supertest'
proxyquire = require('proxyquire').noCallThru()

describe 'App', ->

  describe 'launch without any plugin', ->
    beforeEach ->
      @app = proxyquire '../dist/app',
        './config':
          port: 4567
          plugins: []
    afterEach ->
      @app.get('server').close()

    it 'Should initialize when required', ->
      @app.get('plugins').should.be.defined

    it 'Should respond 200 when post on /', (done)->
      request(@app)
        .post('/')
        .expect 200, done

    it 'Should respond 404 when get /', (done)->
      request(@app)
        .get('/')
        .expect 404, done

  describe 'when launch with a suckin plugin', ->
    beforeEach (done)->
      @debug = []
      @app = proxyquire '../dist/app',
        './config':
          port: 4567
          plugins: ['Plop']
        util:
          debug: (txt)=>
            @debug.push txt
      @app.set 'onReady', done

    it 'would not start', ->
      console.log @app.get('server')
      should.equal @app.get('server'), undefined

    it 'would log a failure', ->
      @debug[0].should.match /Plop/

  describe.only 'when launch with Trello', ->
    beforeEach (done)->
      @debug = []
      trello = require './plugins/trello/config'
      @app = proxyquire '../dist/app',
        './config':
          port: 4567
          plugins: ['trello']
        util:
          debug: (txt)=>
            @debug.push txt
      @app.set 'onReady', done

    afterEach ->
      @app.get('sever').close()

    it 'would start', ->
      console.log @debug[0]
      console.log @app.get('server')
      @app.get('server').should.be.defined
