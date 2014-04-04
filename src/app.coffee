express = require 'express'
fs = require 'fs'
async = require 'async'
util = require 'util'

app = express()
app.use express.json()
app.use express.urlencoded()


app.post '/', (req, res) =>
  res.send {}
  payload = req.body
  plugin.action(payload) for plugin in app.get 'plugins' when plugin.isConcernBy()

# Load plugins
loadPlugins = (config, cb)->
  plugins = {}
  for name in config
    plugins[name] = do (name)->
      (callback)->
        path = [__dirname, 'plugins', name, 'plugin.js'].join '/'
        fs.exists path, (exists)->
          return callback("plugin #{name} not found") unless exists
          plugin = new (require path)()
          missing = []
          for m in ['initialize', 'action', 'isConcernBy'] when not plugin[m]?
            missing.push  m
          if missing.length
            return callback "missing plugin method #{missing.join ', '}", plugin
          plugin.initialize (err)->
            callback err, plugin
  queue = async.parallel plugins, cb


# Load config file and initializes plugins
@config = require './config'
loadPlugins @config.plugins, (err, plugins)=>
  if err
    util.debug err
  else
    util.debug "running #{name for name, plugin of plugins} "
    app.set 'plugins', plugins
    app.set 'server', app.listen @config.port
    console.log "Listening on port #{@config.port}"
  app.get('onReady')?()

module.exports = app
