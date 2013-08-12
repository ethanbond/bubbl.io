express 	= require 'express'
colors		= require 'colors'
dust		= require 'dustjs-linkedin'
cons 		= require 'consolidate'
db			= require 'mongodb'
dbClient	= db.MongoClient
mongoose	= require 'mongoose'
sass		= require 'node-sass'

app 		= express()

routes 		= require './routes'
models		= require './models'

dbClient.connect "mongodb://localhost:27017/test", (err, db) ->
	if err
		console.log "FAILURE: Could not connect to mongodb".red
		console.log err
	else
		console.log "SUCCESS: Connected to mongodb".green
		db.createCollection 'test', {w:1}, (err, collection) ->
			if err
				console.log "FAILURE: Could not create collection".red
				console.log err
			else
				console.log "SUCCESS: Collection created".green

app.set 'view engine', 'dust'
app.set 'template engine', 'dust'
app.engine 'dust', cons.dust

app.set 'views', __dirname + '/views'

app.use sass.middleware {
	src: __dirname + '/source',
	dest: __dirname + '/public',
	debug: true,
	outputStyle: 'nested'	
}

app.use express.bodyParser()
app.use express.static(__dirname + '/public')
app.use app.router

app.get '/', routes.index






app.listen 80
console.log 'Express listening on 80'
console.log 'Good luck!'.green