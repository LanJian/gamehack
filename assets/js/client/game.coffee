class window.Game extends Scene
  constructor: (canvas) ->
    super canvas
    @player1 = 1

    @init()


  init: ->
    base = new Building @player1
    base.setPosition 0, 300
    console.log base
    @addChild base
