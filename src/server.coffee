
express = require 'express'
routes = require './routes'
http = require 'http'
path = require 'path'
server = express()
io = require 'socket.io'

http_server = http.createServer server

serv_io = io.listen http_server

serv_io.configure ->
  serv_io.enable('browser client etag');
  serv_io.set('log level', 1);

  serv_io.set('transports', [
    'websocket'
  , 'flashsocket'
  , 'htmlfile'
  , 'xhr-polling'
  , 'jsonp-polling'
  ])

# ------------------------------ #

server.configure ->
  server.set 'port', process.env.PORT or 3000
  server.set 'views', __dirname + '/views'
  server.set 'view engine', 'jade'
  server.use express.favicon()
  server.use express.logger('dev')
  server.use express.bodyParser()
  server.use express.methodOverride()
  server.use express.cookieParser('seeecrets string')
  server.use express.session()
  server.use server.router
  server.use express.static path.join __dirname, 'public'

server.configure 'development', ->
  server.use express.errorHandler()

# ------------------------------ #

server.get '/', routes.index

messages = new Array()

Array::inject = (data) ->
  @push(data)

# ------------------------------ #

serv_io.sockets.on 'connection', (client) ->
  console.log "New Connection ", client.id

  client.on 'init', ->
    serv_io.sockets.emit 'news', messages

  client.on 'new_post', (data) ->

    messages.inject(data)
    serv_io.sockets.emit 'news', messages
    serv_io.sockets.emit 'new_post', data

  client.on 'disconnect', ->
    console.log "Disconnected: ", client.id

# ------------------------------ #

http_server.listen server.get('port'), ->
  console.log 'express server on port ' + server.get 'port'