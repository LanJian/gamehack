class window.Game extends Scene
  constructor: (canvas) ->
    super canvas
    @init()


  init: ->
    unit = new Unit()
    unit.setPosition 200, 100
    @addChild unit
