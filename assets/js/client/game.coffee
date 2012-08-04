class window.Game extends Scene
  constructor: (@canvas, id, opponentId) ->
    super @canvas
    @player = id
    @opponent = opponentId
    @init()


  init: ->
    @map = new GameObject @playerId
    @map.setSize @size.w+500, @size.h

    #bgSky = new Rect 0, 0, @size.w+500, @size.h-200, 'blue'
    #bgGround = new Rect 0, 150, @size.w+500, 200, 'green'
    bgSprite = new SpriteImage 'background.png'
    @map.addChild bgSprite

    @addBase @player
    @addBase @opponent

    if @player > @opponent
      @map.position.x = -@map.size.w + @canvas.width

    @onKeyDown 39, ( ->
      @scroll 6).bind this
    @onKeyDown 37, ( -> @scroll -6).bind this

    @addChild @map
    #@addUnit @opponent

  addBase: (playerId) ->
    building = new Building playerId
    # fine for now, but maybe use a Player object later?
    if playerId == @player
      if @player < @opponent
        building.setPosition 0, 50
      else
        building.setPosition @map.size.w-building.size.w, 50
      building.addListener 'click', ( -> @addUnit @player).bind this
    else
      if @player > @opponent
        building.setPosition 0, 50
      else
        building.setPosition @map.size.w-building.size.w, 50
    @map.addChild building

  addUnit: (playerId) ->
    height = 270
    if playerId == @player
      if @player < @opponent
        unit = new Tank(@player, 1.1, 10, 'blue')
        unit.setPosition 100, height
        unit.setDirection 1
      else
        unit = new Tank(@player, 1.1, 10, 'red')
        unit.setPosition @map.size.w-100, height
        unit.setDirection -1
    else
      if @player < @opponent
        unit = new Tank(@opponent, 1.1, 10, 'blue')
        unit.setPosition 100, height
        unit.setDirection 1
      else
        unit = new Tank(@opponent, 1.1, 10, 'red')
        unit.setPosition @map.size.w-100, height
        unit.setDirection -1
    unit.addListener 'click', -> console.log 'click unit'
    @map.addChild unit


  scroll: (dist) ->
    @map.position.x -= dist
    if @map.position.x > 0
      @map.position.x = 0
    else if @map.position.x < -@map.size.w + @canvas.width
      @map.position.x = -@map.size.w + @canvas.width
