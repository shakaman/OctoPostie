require 'chai'
request = require 'supertest'
nock = require 'nock'

describe 'App', ->
  beforeEach ->
    @app = require '../dist/app'

  it 'Should initialize when required', ->
    
  it 'Should respond 200 when post on /', (done)->
    request(@app)
      .post('/')
      .expect 200, done

  it 'Should respond 404 when get /', (done)->
    request(@app)
      .get('/')
      .expect 404, done
