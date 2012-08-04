http = require('http')
express = require('express')
app = express()
server = http.createServer(app)
io = require('socket.io').listen(server)
stylus = require('stylus')
assets = require('connect-assets')

io.set("log level", 0)

app.use assets()
app.use express.bodyParser()
app.use express.static "#{__dirname}/assets"
app.set 'view engine', 'jade'

app.get('/', (req, res) ->
  return res.render('index')
)

io.sockets.on('connection', (socket) ->
  console.log "connection"
  socket.on('blah', (data) ->
    #io.sockets.emit('chat message', data);
    console.log "blah"
  )
)

server.listen 3000
console.log "Listening on port 3000"
