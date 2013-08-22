# Includes
## Server
express 	= require 'express'
app 		= express()
server 		= require('http').createServer app
io 			= require('socket.io').listen server

## Utilities
colors		= require 'colors'

## Locations
Routes 		= require './routes'
Db 			= require './db'
Models 		= require './models'

## Front-end
dust		= require 'dustjs-linkedin'
cons 		= require 'consolidate'
sass		= require 'node-sass'



# Configuration
## Locations
app.set 'views', __dirname + '/views'
app.use express.static(__dirname + '/public')

## Front-end
app.set 'view engine', 'dust'
app.set 'template engine', 'dust'
app.engine 'dust', cons.dust
app.use sass.middleware {			# Compile sass from /source to /public
	src: __dirname + '/source',
	dest: __dirname + '/public',
	debug: true,
	outputStyle: 'nested'	
}

## Utilities
app.use app.router
app.use express.errorHandler()

app.get  '/', 				Routes.index
app.post '/',		  		Routes.upload
app.get  '/b:bubblid',		Routes.viewBubbl



########################################################
##################### Start server #####################
########################################################

Db.connect 'mongodb://127.0.0.1/test'
server.listen 3000
console.log 'SUCCESS: Express listening on 3000'.green
console.log 'INFO:    Good luck!'.cyan