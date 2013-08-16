mongoose 	= require 'mongoose'
Chance		= require 'chance'

Bubbl 		= require './Bubbl'

ObjectID 	= mongoose.Types.ObjectId


one_week 	= (7 * 24 * 60 * 60)

randomUrl	= () -> 
	chance = new Chance () ->
		return Math.random()
	return chance.string {length: 7, pool: 'ahijkoqruwx'}



linkSchema = new mongoose.Schema {
	url:
		type: String
		default: null
	expiration:
		type: Date
		default: Date.now() + one_week
	bubbl: [ObjectID]
}


linkSchema.methods =
	test: ->
		console.log "URL:        ", this.url
		console.log "EXPIRATION: ", this.expiration
		console.log "BUBBL:      ", this.bubbl
	genUrl: ->
		rand = randomUrl()
		this.url = rand
		this.update(
			$set:
				url: rand
			(err) ->
				if err then console.log err	
				return rand
		)
	getString: () ->
		return this.url
	assign: (id, e) ->
		url = this.url
		this.update(
			$push:
				bubbl: id
			upsert: true
			(err) ->
				if err
					console.log err
					e true, err
				else
					e false, url
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