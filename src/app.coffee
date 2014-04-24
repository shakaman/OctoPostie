express = require 'express'
fs = require 'fs'


app = express()
app.use express.json()
app.use express.urlencoded()


app.post '/', (req, res) ->
  res.send {}
  payload = req.body
  plugin.action(payload) for plugin in @plugins when plugin.isConcernBy(payload)


# Load config file and initializes plugins
initialize = ->
  @config = require './config'
  loadPlugins()
  launchServer()


# Load plugins
loadPlugins = ->
  path = "#{__dirname}/plugins"
  @plugins = for name in @config.plugins
    new (require "#{path}/#{name}/plugin")()
  plugin.initialize?() for plugin in @plugins

launchServer = ->
  app.listen @config.port
  console.log "Listening on port #{@config.port}"


initialize()
module.exports = app
