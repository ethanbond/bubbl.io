express 	= require 'express'
colors		= require 'colors'
dust		= require 'dustjs-linkedin'

app = express()

app.get '/', (req, res) ->
	res.send 'Bubbl.io Testing test!'

app.listen 3000
console.log 'Express listening on 3000'
console.log 'Good luck!'.green
