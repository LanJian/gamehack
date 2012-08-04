class window.Game extends Scene
  constructor: (canvas) ->
    super canvas
    @init()


  init: ->
    unit = new Unit(1, 1.1, 'hibiki.png', 1, 25, 10)
    unit.setPosition 100, 100
    unit.setDirection 1
    @addChild unit
