express = require 'express'
fs = require 'fs'


app = express()
app.use express.json()
app.use express.urlencoded()


app.post '/', (req, res) ->
  res.send {}
  # return unless ready
  payload = req.body


# Initialize configuration
initialize = ->
  path = "#{__dirname}/plugins"
  @plugins = for file in fs.readdirSync path
    require "#{path}/#{file}"
  plugin.initialize() for plugin in @plugins


initialize()
app.listen config.port, ->
  console.log "Listening on port #{config.port}"

