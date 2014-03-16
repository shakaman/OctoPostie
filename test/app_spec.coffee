chai = require 'chai'
sinon = require 'sinon'
sinonChai = require 'sinon-chai'
chai.should()
chai.use(sinonChai)

request = require 'supertest'
proxyquire = require 'proxyquire'

describe 'App', ->

  before ->
    @app = proxyquire('../dist/app',
      './config': {
        port: 4567
        plugins: []
      }
    )

  it 'Should initialize when required', ->
    
  it 'Should respond 200 when post on /', (done)->
    request(@app)
      .post('/')
      .expect 200, done

  it 'Should respond 404 when get /', (done)->
    request(@app)
      .get('/')
      .expect 404, done
