class window.Game extends Scene
  constructor: (canvas) ->
    super canvas
    @init()
    @player1 = 1


  init: ->
    base = new Building @player1
