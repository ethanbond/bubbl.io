Db			= require '../db'
Grid		= require 'gridfs-stream'
mongoose	= require 'mongoose'
Grid.mongo	= mongoose.mongo

fs 			= require 'fs'

module.exports =
	index: (req, res) ->
		res.render "index"
	addToBubbl: (req, res) ->
		res.render "index"
	upload: (req, res) ->
		# make new bubbl instance
		for key, value of req.files
			# make new file instance



			gfs = Grid Db.connection
			console.log value
			writestream = gfs.createWriteStream({_id: 1402})
			writestream.on 'error', (err) ->
				console.log 'FAILURE: Writestream failure'.red 
				throw err
			console.log 'SUCCESS: GridFS writestream opened'.green
			console.log 'INFO: File stream: '.cyan+value._writeStream.path.cyan
			fs.createReadStream(value._writeStream.path).pipe(writestream)
			console.log 'SUCCESS: GridFS steam connected to form stream'.green
			# add file instance to new bubbl
