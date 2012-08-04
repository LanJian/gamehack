$(document).ready ->
  init()

init = ->
  canvas = $('#canvas')[0]
  game = new Game canvas
