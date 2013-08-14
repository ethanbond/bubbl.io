mongoose	= require 'mongoose'
conn = null

module.exports =
	connect: connect = (url) ->
		conn = mongoose.createConnection url
		conn.once 'open', () ->
			console.log 'SUCCESS: Connected to mongodb'.green
	connection: connection = () ->
		return conn


