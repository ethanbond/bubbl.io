mongoose 	= require 'mongoose'
Schema 		= mongoose.Schema

fileSchema = Schema {
	id: Number
	filename: String
	extension: String
	size: Number
	date_added: Number
	date_edited: Number
}

module.exports = fileSchema