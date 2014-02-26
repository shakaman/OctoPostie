express = require 'express'
fs = require 'fs'


app = express()
app.use express.json()
app.use express.urlencoded()


app.post '/', (req, res) ->
  res.send {}
  # return unless ready
  payload = req.body
  plugin.action(payload) for plugin in @plugins


# Initialize configuration
initialize = ->
  path = "#{__dirname}/plugins"
  @plugins = for file in fs.readdirSync path
    new (require "#{path}/#{file}/plugin")()
  plugin.initialize() for plugin in @plugins


initialize()
app.listen 4567, ->
  console.log "Listening on port 4567"

