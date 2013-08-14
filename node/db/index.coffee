mongoose	= require 'mongoose'
conn = null

module.exports =
	connect: (url) ->
		conn = mongoose.connect url
		console.log 'SUCCESS: Connected to mongodb'.green
	connection: () ->
		return conn


