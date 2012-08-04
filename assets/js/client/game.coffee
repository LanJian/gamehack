class window.Game extends Scene
  constructor: (@canvas) ->
    super @canvas
    @playerId = 1
    @init()


  init: ->
    @map = new GameObject @playerId

    bg = new Rect 0, 0, @size.w+500, @size.h, 'white'
    @map.addChild bg

    building = new Building @playerId
    building.setPosition 0, 50
    building.addListener 'click', @addUnit.bind this
    @map.addChild building

    @onKeyDown 39, ( ->
      @scroll 3).bind this
    @onKeyDown 37, ( -> @scroll -3).bind this

    @addChild @map

  addUnit: ->
    console.log this
    unit = new Unit(@playerId, 1.1, 'hibiki.png', 1, 25, 10)
    unit.setPosition 100, 100
    unit.setDirection 1
    @map.addChild unit


  scroll: (dist) ->
    @map.position.x -= dist
    if @map.position.x > 0
      @map.position.x = 0
    else if @map.position.x < -@map.size.w + @canvas.width
      @map.position.x = -@map.size.w + @canvas.width
