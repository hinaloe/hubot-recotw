# Description
#   A Hubot script to integrate RecoTw.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot register <Tweet URL> - register Tweet to RecoTw
#   hubot black - random pick tweet from RecoTw
#   hubot black <screen_name> - random pick selected user's tweet from RecoTw
#   hubot latest black - Get Latest Tweet in RecoTw
#
# Author:
#   hina <hina@hinaloe.net>
#

global.Promise = require 'promise'

module.exports = (robot) ->
  recotw = require "recotw-js"
  recotw.setEndpoint 'http://api.recotw.black'
  robot.respond /register (?:(?:https?:\/\/(?:www\.|mobile\.)?)?twitter\.com\/(?:#!\/)?[a-zA-Z0-9_]+\/status(?:es)?\/(\d+)|(\d+))/i, (msg) ->
    tweet_id = msg.match[1] or msg.match[2]
    # console.log tweet_id
    if tweet_id
      recotw.Resources.Tweet.record_tweet id: tweet_id
      .then (data)->
         msg.reply "OK: (at)#{data.target_sn} #{data.content}"
      .catch (err)->

            # console.log err
            msg.reply err.response.res.text

  robot.respond /black(?:\s([a-zA-Z0-9_]+)?)/i, (msg) ->
    sn = msg.match[1]
    if sn
      recotw.Resources.Tweet.user_tweet sn: sn
      .then (data) ->
        if data
          item = data[Math.floor Math.random() * data.length]
          msg.send "#{item.target_sn}: #{item.content} https://twitter.com/#{item.target_sn}/status/#{item.tweet_id}"
      .catch (err)->
        msg.reply err.response.res.text

  robot.respond /black$/i, (msg) ->
    recotw.Resources.Tweet.get_tweet_all()
    .then (data) ->
      if data
        item = data[Math.floor Math.random() * data.length]
        msg.send "#{item.target_sn}: #{item.content} https://twitter.com/#{item.target_sn}/status/#{item.tweet_id}"
    .catch (err)->
      msg.reply err.response.res.text

  robot.respond /latest-black$/i, (msg) ->
    recotw.Resources.Tweet.get_tweet_all()
    .then (data) ->
      if data
        item = data[data.length-1]
        msg.send "#{item.target_sn}: #{item.content} https://twitter.com/#{item.target_sn}/status/#{item.tweet_id}"
    .catch (err)->
      msg.reply err.response.res.text
