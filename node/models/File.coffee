mongoose 	= require 'mongoose'

fileSchema = new mongoose.Schema {
	filename: String
	extension: String
	size: Number
	dates:
		added:
			type: Date
			default: Date.now
		edited:
			type: Date
			default: Date.now
		viewed:
			type: Date
			default: Date.now
}



module.exports = mongoose.model 'File', fileSchema