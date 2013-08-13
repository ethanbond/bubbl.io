mongo = require 'mongodb'

module.exports = ->
	(new mongo.Db 'test', new mongo.Server '127.0.0.1', 27017, {auto_reconnect: true}).open (err, db) ->
		if err return
		console.log 'established'.green
