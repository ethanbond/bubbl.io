Db			= require '../db'
Grid		= require 'gridfs-stream'
mongoose	= require 'mongoose'
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
	upload: 	(req, res, next) ->
		bubbl = new Bubbl.model
		bubbl.genLink()
		console.log 'SUCCESS: New bubbl generated'.green


		bubbl.save (err, bubbl) ->
			if err
				console.log 'FAILURE: Could not save new bubbl to MongoDB'.red
				return
			for key, value of req.files
				file = new File.model
				file.save (err, file) ->
					gfs = Grid Db.connection, mongoose.mongo
					writestream = gfs.createWriteStream {
						_id: file._id
					}
					writestream.on 'open', () ->
						readstream = fs.createReadStream value.toString()
						readstream.on 'open', () ->
							readstream.pipe writestream
					writestream.on 'close', (file) ->
						console.log 'writestream closed'
						bubbl.addFile file
