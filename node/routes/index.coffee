module.exports =
	index: (req, res) ->
		res.render "index", 
			metadata:
				title: "bubbl.io"
				description: "A fast, free file collaboration website. No registration necessary. Live editing, 25MB file limit, unlimited storage, and more. Coming soon."