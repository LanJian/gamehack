playerIdCounter = 1
playerCounter = 0
playerOneId = 0
playerTwoId = 0
module.exports = (io) ->
  io.sockets.on('connection', (socket) ->
    console.log "connection"
    socket.emit('player id', {'id': playerIdCounter})

    playerCounter++
    if playerCounter == 1
      playerOneId = playerIdCounter
    if playerCounter == 2
      playerTwoId = playerIdCounter
      io.sockets.emit('new game', {"playerOneId": playerOneId, "playerTwoId": playerTwoId})

    socket.on('blah', (data) ->
      #io.sockets.emit('chat message', data);
      console.log "blah"
    )

    socket.on('disconnect', (socket) ->
      playerCounter--
      if playerCounter == 0
        playerIdCounter = 1
    )
    playerIdCounter++
  )
