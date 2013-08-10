module.exports =
	index: (req, res) ->
		res.render "index", 
			metadata:
				title: "Home"
				description: "Lorem"