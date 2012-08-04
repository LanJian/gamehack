class window.Game extends Scene
  constructor: (@canvas) ->
    super @canvas
    @player = 1
    @opponent = 2
    @init()


  init: ->
    @map = new GameObject @playerId
    @map.setSize @size.w+500, @size.h

    bg = new Rect 0, 0, @map.size.w, @map.size.h, 'white'
    @map.addChild bg

    @addBase @player
    @addBase @opponent

    @onKeyDown 39, ( ->
      @scroll 6).bind this
    @onKeyDown 37, ( -> @scroll -6).bind this

    @addChild @map
    @addUnit @opponent

  addBase: (playerId) ->
    building = new Building playerId
    # fine for now, but maybe use a Player object later?
    if playerId == @player
      building.setPosition 0, 50
      building.addListener 'click', ( -> @addUnit @player).bind this
    else
      building.setPosition @map.size.w-building.size.w, 50
    @map.addChild building
    console.log @map.children

  addUnit: (playerId) ->
    console.log this
    unit = new Unit(playerId, 1.1, 'hibiki.png', 1, 25, 10)
    if playerId == @player
      unit.setPosition 100, 100
      unit.setDirection 1
    else
      unit.setPosition @map.size.w-100, 100
      unit.setDirection -1
    @map.addChild unit


  scroll: (dist) ->
    @map.position.x -= dist
    if @map.position.x > 0
      @map.position.x = 0
    else if @map.position.x < -@map.size.w + @canvas.width
      @map.position.x = -@map.size.w + @canvas.width
