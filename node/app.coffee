express 	= require 'express'
colors		= require 'colors'
dust		= require 'dustjs-linkedin'

app = express()

app.get '/', (req, res) ->
	res.send 'Bubbl.io Testing'

app.listen 3000
console.log 'EXPRESS SERVER STARTED'.green
