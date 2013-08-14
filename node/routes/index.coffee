Db			= require '../db'
Grid		= require 'gridfs-stream'
mongoose	= require 'mongoose'
Grid.mongo	= mongoose.mongo
Models 		= require '../models'
Bubbl 		= Models.Bubbl
File 		= Models.File
Link 		= Models.Link

fs 			= require 'fs'

module.exports =
	index:		(req, res) ->
		res.render "index"
	addToBubbl: (req, res) ->
		res.render "index"
	upload: 	(req, res) ->
		bubbl = new Bubbl.model
		bubbl.genLink()
		console.log 'SUCCESS: New bubbl generated'.green
		bubbl.save (err, bubbl) ->
			if err
				console.log 'FAILURE: Could not save new bubbl to MongoDB'.red
				return
			console.log 'SUCCESS: New bubbl saved to MongoDB'.green
			for key, value of req.files

				# res.send value.name
				console.log value

				file = new File.model
				file.save (err, file) ->
					console.log 'SUCCESS: New file saved to MongoDB'.green
					gfs = Grid Db.connection
					writestream = gfs.createWriteStream (_id: file._id)						
					writestream.on 'error', (err) ->
						console.log 'FAILURE: Writestream failure'.red 
						throw err
					value._writeStream.pipe(writestream)
					writestream.on 'close', (file) ->
						console.log 'done'
						console.log file.filename

					# bubbl.addFile file