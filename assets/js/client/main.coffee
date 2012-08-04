$(document).ready ->
  #init()

window.socket = io.connect(window.location.href)
id = 0
type = 'tank'
opponentId = 10000
game = null

#init = ->
#  canvas = $('#canvas')[0]
#  game = new Game canvas

socket.on("player id", (data) ->
  console.log data['id']
  id = data['id']
  # canvas = $('#canvas')[0]
  # game = new Game canvas, id, opponentId
)

socket.on("new game", (data) ->
  console.log 'new game'
  if data['playerOneId'] == id
    opponentId = data['playerTwoId']
  else
    opponentId = data['playerOneId']
  canvas = $('#canvas')[0]
  game = new Game canvas, id, opponentId
  console.log 'id ' + id + ' opp ' + opponentId
)

socket.on('in queue', (data) ->
  alert "players are playing, you're in line, refresh"
)

socket.on('add unit', (data) ->
  game.addUnit data['playerId'], 1, data['type']
  #if type == 'tank'
    #type = 'soldier'
    #console.log type
    #game.addUnit data['playerId'] ,1 ,type
  #else
    #type = 'tank'
    #game.addUnit data['playerId'] ,1 ,type
  #console.log data['playerId']
  console.log new Date().getTime()
)
