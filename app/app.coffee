#= require 'config'

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
  @plugins = for path in fs.readdirSync './plugins'
    require path
  plugin.initialize() for plugin in @plugins


initialize()
app.listen config.port, ->
  console.log "Listening on port #{config.port}"

