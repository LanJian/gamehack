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
    height = 210
    building = new Building playerId
    building.setSize 226, 100
    console.log [building.size.w, building.size.h]
    # fine for now, but maybe use a Player object later?
    if playerId == @player
      if @player < @opponent
        building.setPosition 0, height
      else
        building.setPosition @map.size.w-building.size.w, height
      #building.addListener 'click', ( -> @addUnit @player).bind this
      building.addListener 'click', (() ->
        socket.emit('add unit', {'playerId': @player})
      ).bind this
    else
      if @player > @opponent
        building.setPosition 0, height
      else
        building.setPosition @map.size.w-building.size.w, height
    @map.addChild building

  addUnit: (playerId, unitId, type) ->
    height = 270
    console.log 'add unit input ' + playerId
    console.log 'playerId ' + @player
    if playerId == @player
      if @player < @opponent
        if type == 'tank'
          unit = new Tank(@player, 1.1, 10, 'blue')
        else
          unit = new Soldier(@player, 1.1, 5, 'blue')
        unit.setPosition 100, height
        unit.setDirection 1
      else
        if type == 'tank'
          unit = new Tank(@player, 1.1, 10, 'red')
        else
          unit = new Soldier(@player, 1.1, 5, 'red')
        unit.setPosition @map.size.w-100, height
        unit.setDirection -1
    else
      if @player > @opponent
        if type == 'tank'
          unit = new Tank(@player, 1.1, 10, 'red')
        else
          unit = new Soldier(@player, 1.1, 5, 'red')
        unit.setPosition 100, height
        unit.setDirection 1
      else
        if type == 'tank'
          unit = new Tank(@player, 1.1, 10, 'blue')
        else
          unit = new Soldier(@player, 1.1, 5, 'blue')
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
