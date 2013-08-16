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

parseName = (filename) ->
	filename = filename.split '.'
	filename[0] = filename[0][5..filename[0].length]
	ext = filename[filename.length-1]
	filename = filename.splice 0, filename.length-2
	filename = filename.join '.'
	return [filename, ext]

module.exports =
	index:		(req, res) ->
		res.render "index"
	viewBubbl: (req, res) ->
		res.render "index",
			id: req.params.bubblid
	upload: 	(req, res) ->
		bubbl = new Bubbl.model
		bubbl.genLink()
		console.log 'SUCCESS: New bubbl generated'.green
		bubbl.save (err, bubbl) ->
			if err then console.log 'FAILURE: Could not save new bubbl to MongoDB'.red

			options = 
				limit: 30 * 1024
				diskLimit: 30 * 1024 * 1024

			parser = new multipart req.headers['content-type'], options
			parts = {}

			parser.on 'error', (err) ->
				req.destroy()
				console.log err.red
				next err

			parser.on 'data', () ->
				console.log this.written

			parser.on 'part', (field, part) ->
				console.log 'INFO:  New part'.cyan
				parsedName = parseName part
				ObjectId = mongoose.Types.ObjectId
				id = new ObjectId
				options = 
					_id: id
					metadata:
						filename: parsedName[0]
						extension: parsedName[1]
						expiration: Date.now() + (7 * 24 * 60 * 60)
				writeStream = GridStream.createGridWriteStream 'test', parsedName[0], 'w', options
				writeStream.write part
				writeStream.end()
				bubbl.addFile id
				if part then fs.unlink part, (err) ->
					if err then throw err
				parts[field] = part

			parser.on 'end', () ->
				console.log 'SUCCESS: Multipart form parsed'.green
				res.redirect('/'+bubbl.getLast())

			req.pipe(parser)
