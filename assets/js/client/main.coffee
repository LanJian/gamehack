$(document).ready ->
  #init()

socket = io.connect("http://localhost:3000")
id = 0
opponentId = 10000

#init = ->
#  canvas = $('#canvas')[0]
#  game = new Game canvas

socket.on("player id", (data) ->
  console.log data['id']
  id = data['id']
  canvas = $('#canvas')[0]
  game = new Game canvas, id, opponentId
)

socket.on("new game", (data) ->
  console.log 'new game'
  if data['playerOneId'] == id
    opponentId = data['playerTwoId']
  else
    opponentId = data['playerOneId']
  game = new Game canvas, id, opponentId
  console.log 'id ' + id + ' opp ' + opponentId
)
