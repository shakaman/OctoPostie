chai = require 'chai'
sinon = require 'sinon'
sinonChai = require 'sinon-chai'
chai.should()
chai.use(sinonChai)

request = require 'supertest'
proxyquire = require('proxyquire').noCallThru()

config = require './config'

describe 'Plugin Trello', ->
  beforeEach ->
    @plugin = new (proxyquire('../../../dist/plugins/trello/plugin',
      './config': config
    ))()
    @configSpy = sinon.spy @plugin, 'getConfig'
    @plugin.initialize()

  afterEach ->
    @configSpy.restore()

  it 'Should initialize when required', ->

  it 'Should call getConfig when initializing', ->
    @configSpy.should.have.been.calledOnce

