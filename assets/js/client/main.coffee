$(document).ready ->
  init()

init = ->
  canvas = $('#canvas')[0]
  game = new Game canvas
  socket = io.connect("http://localhost:3000")

#socket.on("blah", (data) ->
#  console.log "test"
#}
