mongoose 	= require 'mongoose'
Schema 		= mongoose.Schema

File 		= require './File'
Link		= require './Link'

Bubbl = new Schema {
	files: [File]
	urls: [Link]
}

Bubbl.methods =
	checkExpiration: checkExpiration = (res) ->
		if this.urls.length is 1
			# bubbl is no longer good
			# delete this bubbl and all files
			this.urls = null
			res.send "Expired"
		else
			res.render 


module.exports = mongoose.model "Bubbl", Bubbl