class window.Game extends Scene
  constructor: (canvas) ->
    super canvas
    @playerId = 1
    @init()


  init: ->
    building = new Building @playerId
    building.setPosition 0, 50
    @addChild building

    building.addListener 'click', ( -> @addUnit()).bind this

  addUnit: ->
    console.log this
    unit = new Unit(1, 1.1, 'hibiki.png', 1, 25, 10)
    unit.setPosition 100, 100
    unit.setDirection 1
    @addChild unit

