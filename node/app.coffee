express 	= require 'express'
colors		= require 'colors'
dust		= require 'dustjs-linkedin'

app = express()

app.get '/', (req, res) ->
	res.send 'Bubbl.io Testing test test again!!'

app.listen 80
console.log 'Express listening on 80'
console.log 'Good luck!'.green
