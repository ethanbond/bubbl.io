mongoose 	= require 'mongoose'
Chance		= require 'chance'
chance 		= new Chance

Bubbl 		= require './Bubbl'


one_week 	= (7 * 24 * 60 * 60)
randomUrl	= () -> return chance.string {length: 7, pool: 'ahijkoqruwx'}



linkSchema = new mongoose.Schema {
	url:
		type: String
		default: randomUrl()
	expiration:
		type: Date
		default: Date.now() + one_week
	bubbl: String
}


linkSchema.methods =
	test: ->
		console.log "URL:        ", this.url
		console.log "EXPIRATION: ", this.expiration
		console.log "BUBBL:      ", this.bubbl
	getString: () ->
		return this.url
	assign: (id, callback) ->
		this.update(
			$push:
				bubbl: id
			upsert: true
			(err) ->
				if err
					console.log err
					callback err
				callback false
		)
	checkExpiration: (req, res) ->
		if Date.now.getTime > this.expiration.getTime
			bubbl.checkExpiration
			# delete this Link
			res.send 'Not found'
		else
			this.expiration.setTime (Date.now.getTime + one_week)
			bubbl.fetch


module.exports =
	model: mongoose.model "Link", linkSchema
	schema: linkSchema