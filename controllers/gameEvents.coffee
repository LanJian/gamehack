playerIdCounter = 1
playerCounter = 0
module.exports = (io) ->
  io.sockets.on('connection', (socket) ->
    socket.emit('player id', {'id': playerIdCounter})
    playerIdCounter++

    playerCounter++
    if playerCounter == 2
      io.sockets.emit('new game')

    console.log "connection"
    socket.on('blah', (data) ->
      #io.sockets.emit('chat message', data);
      console.log "blah"
    )

    socket.on('disconnect', (socket) ->
      playerCounter--
      if playerCounter == 0
        playerIdCounter = 1
    )
  )
