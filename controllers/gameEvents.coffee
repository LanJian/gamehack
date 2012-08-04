playerIdCounter = 1
playerCounter = 0
playerOneId = 0
playerTwoId = 0
module.exports = (io) ->
  io.sockets.on('connection', (socket) ->
    if playerCounter == 0
      socket.emit('waiting for player')

    if playerCounter >= 2
      socket.emit('in queue')
      return

    console.log "connection"
    console.log 'playerid:' + playerCounter
    socket.emit('player id', {'id': playerIdCounter})

    playerCounter++
    if playerCounter == 1
      playerOneId = playerIdCounter
    if playerCounter == 2
      playerTwoId = playerIdCounter
      io.sockets.emit('new game', {"playerOneId": playerOneId, "playerTwoId": playerTwoId})

    socket.on('add unit', (data) ->
      io.sockets.emit('add unit', data)
    )

    socket.on('game over', (data) ->
      console.log 'game over lols'
      playerIdCounter = 1
      playerCounter = 0
      playerOneId = 0
      playerTwoId = 0
      io.sockets.emit('game over', data)
    )

    socket.on('disconnect', (socket) ->
      playerCounter--
      if playerCounter <= 0
        playerCounter = 0
        playerIdCounter = 1
    )
    playerIdCounter++
  )
