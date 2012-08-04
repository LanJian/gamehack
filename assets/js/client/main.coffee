$(document).ready ->
  #init()

socket = io.connect("http://localhost:3000")
id = 0

#init = ->
#  canvas = $('#canvas')[0]
#  game = new Game canvas

socket.on("player id", (data) ->
  console.log data['id']
  id = data['id']
  canvas = $('#canvas')[0]
  game = new Game canvas, id
)

socket.on("new game", (data) ->
  console.log 'new game'
  game = new Game canvas, id
)
