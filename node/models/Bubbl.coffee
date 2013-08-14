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
	addFile: (file) ->
		this.files.push file
	genLink: ->
		this.urls.push new Link.model
		id = this._id
		last = this.urls[this.urls.length - 1]
		last.assign id, (err) ->
			if err then return
			return last.getString()
		return
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