module.exports = (io) ->
  io.sockets.on('connection', (socket) ->
    console.log "connection"
    socket.on('blah', (data) ->
      #io.sockets.emit('chat message', data);
      console.log "blah"
    )
  )
