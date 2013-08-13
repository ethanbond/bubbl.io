mongo		= require 'mongodb'
mongoose	= require 'mongoose'
Grid		= require 'gridfs-stream'

module.exports =
	index: (req, res) ->
		res.render "index"
	upload: (req, res) ->
		res.send JSON.stringify file for file, data in req.files
