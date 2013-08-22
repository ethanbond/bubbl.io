mongoose 	= require 'mongoose'
Schema 		= mongoose.Schema

File 		= require './File'
Link		= require './Link'

bubblSchema = new Schema {
	files: Array
	urls: Array
}

bubblSchema.methods =
	test: -> 
		console.log "SUCCESS: Bubbl object created, methods working".green
		console.log "ID:      ".cyan, this._id		
		console.log "URLS:    ".cyan, this.urls
		console.log "FILES:   ".cyan, this.files
	fetch: (url) ->
		query = this.find(
			urls: { $in: url }
		)

	getLast: () ->
		return this.urls[this.urls.length-1]
	addUrl: (url) ->
		this.urls.push url
		this.update(
			$push:
				urls: url
			upsert: true
			(err) ->
				if err
					console.log err
				else 
					console.log 'SUCCESS: Added url'.green, url.green, 'to bubbl'.green
		)
	addFile: (file) ->
		this.update(
			$pushAll:
				files: [file]
			upsert: true
			(err) ->
				if err then console.log err
		)
	genLink: ->
		link = new Link.model
		bubbl = this
		id = bubbl._id
		link.genUrl()
		link.save (err, link) ->
			if err then console.log 'FAILURE: Could not save new link to MongoDB'.red
			link.assign id, (e, response) ->
				if e then console.log 'FAILURE: Could not assign bubbl to link'.red
				bubbl.addUrl response

	checkExpiration: (res) ->
		if this.urls.length is 1
			# bubbl is no longer good
			# delete this bubbl and all files
			this.urls = null
			res.send "Expired"
		else
			res.send "All good"


module.exports =
	model: mongoose.model "Bubbl", bubblSchema
	schema: bubblSchema