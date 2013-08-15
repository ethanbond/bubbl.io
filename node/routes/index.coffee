Db			= require '../db'
GridStream	= require('GridFS').GridStream
mongoose	= require 'mongoose'
Models 		= require '../models'
fs 			= require 'fs'

parted 		= require 'parted'
multipart 	= parted.multipart

Bubbl 		= Models.Bubbl
File 		= Models.File
Link 		= Models.Link




getExt = (filename) ->
	filename = filename.split '.'
	return filename[filename.length-1]

module.exports =
	index:		(req, res) ->
		res.render "index"
	addToBubbl: (req, res) ->
		res.render "index"
	upload: 	(req, res, next) ->
		bubbl = new Bubbl.model
		bubbl.genLink()
		console.log 'SUCCESS: New bubbl generated'.green
		bubbl.save (err, bubbl) ->
			if err
				console.log 'FAILURE: Could not save new bubbl to MongoDB'.red
				return

			options = 
				limit: 30 * 1024
				diskLimit: 30 * 1024 * 1024

			parser = new multipart req.headers['content-type'], options
			parts = {}

			parser.on 'error', (err) ->
				req.destroy()
				console.log err.red
				next err

			parser.on 'part', (field, part) ->
				console.log 'INFO:  New part'.cyan
				parts[field] = part

			parser.on 'data', () ->
				console.log 'INFO:  New data block'.cyan
				console.log this.written

			parser.on 'end', () ->
				console.log parts
				console.log 'SUCCESS: Multipart form parsed'.green

			writeStream = GridStream.createGridWriteStream 'test', bubbl._id, 'w'
			writeStream.write req.pipe(parser)
			writeStream.end()

