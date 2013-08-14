mongoose 	= require 'mongoose'
chance		= require 'chance'

Bubbl 		= require './Bubbl'


one_week 	= (7 * 24 * 60 * 60)
randomUrl	= () ->
	return 'blah'



Link = new mongoose.Schema {
	url:
		type: String
		default: randomUrl()
	expiration:
		type: Date
		default: new Date(Date.getTime + one_week)
	bubbl: Bubbl
}


Link.methods =
	assign: assign = (req, res) ->
		bubbl = req.params.bubbl
	checkExpiration: checkExpiration = (req, res) ->
		if Date.now.getTime > this.expiration.getTime
			bubbl.checkExpiration
			# delete this Link
			res.send 'Not found'
		else
			this.expiration.setTime (Date.now.getTime + one_week)
			bubbl.fetch


module.exports = mongoose.model "Link", Link