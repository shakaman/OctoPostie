Twit = require 'twit'

class TweetUpdate
  initialize: ->
    # Specific config file for this plugin
    config = require './config'
    @regex = config.regex
    @twitter = new Twit
      consumer_key: config.twitter.api.key
      consumer_secret: config.twitter.api.secret
      access_token: config.twitter.token.access
      access_token_secret: config.twitter.token.secret


  action: (@payload)->
    @tweetUpdate()


  isConcernBy: (payload)->
    @hasTag(payload) and @tagIsValid(payload) and not @isPrivate(payload)


  hasTag: (payload)->
    payload.ref.indexOf('tags') > 0


  tagIsValid: (payload)->
    payload.ref.match(@regex)?.length > 0


  isPrivate: (payload)->
    payload.repository.private


  tweetUpdate: ->
    version = @payload.ref.match(@regex)[1]
    msg = "#{@payload.repository.name} #{version} is out. #{@payload.repository.url}"
    @twitter.post 'statuses/update',
      status: msg
    , (err, reply) ->


module.exports = TweetUpdate
