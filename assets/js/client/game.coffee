class window.Game extends Scene
  constructor: (@canvas, id, opponentId) ->
    super @canvas
    @player  = new Player id
    @opponent = new Player opponentId
    @refresh = false

    @init()


  init: ->
    @map = new GameObject @player.id
    @map.setSize @size.w+500, @size.h

    #bgSky = new Rect 0, 0, @size.w+500, @size.h-200, 'blue'
    #bgGround = new Rect 0, 150, @size.w+500, 200, 'green'
    bgSprite = new SpriteImage 'background.png'
    @map.addChild bgSprite

    @addBase @player.id
    @addBase @opponent.id

    if @player.id > @opponent.id
      @map.position.x = -@map.size.w + @canvas.width

    @onKeyDown 39, ( ->
      @scroll 6).bind this
    @onKeyDown 37, ( -> @scroll -6).bind this

    @addChild @map

  addBase: (playerId) ->
    height = 210
    building = new Building playerId
    building.setSize 226, 100
    # fine for now, but maybe use a Player object later?
    if playerId == @player.id
      if @player.id < @opponent.id
        building.setPosition 0, height
      else
        building.setPosition @map.size.w-building.size.w, height
      building.addListener 'click', (() ->
        socket.emit('add unit', {'playerId': @player.id})
      ).bind this
      @player.addBuilding building
    else
      if @player.id > @opponent.id
        building.setPosition 0, height
      else
        building.setPosition @map.size.w-building.size.w, height
      @opponent.addBuilding building
    @map.addChild building

  addUnit: (playerId, unitId, type) ->
    height = 270
    if type != "tank"
      height = 290
    if playerId == @player.id
      if @player.id < @opponent.id
        if type == 'tank'
          unit = new Tank(@player.id, 1.1, 'blue')
        else
          unit = new Soldier(@player.id, 1.1, 'blue')
        unit.setPosition 100, height
        unit.setDirection 1
      else
        if type == 'tank'
          unit = new Tank(@player.id, 1.1, 'red')
        else
          unit = new Soldier(@player.id, 1.1, 'red')
        unit.setPosition @map.size.w-100, height
        unit.setDirection -1
      @player.addUnit unit
    else
      if @player.id > @opponent.id
        if type == 'tank'
          unit = new Tank(@opponent.id, 1.1, 'blue')
        else
          unit = new Soldier(@opponent.id, 1.1, 'blue')
        unit.setPosition 100, height
        unit.setDirection 1
      else
        if type == 'tank'
          unit = new Tank(@opponent.id, 1.1, 'red')
        else
          unit = new Soldier(@opponent.id, 1.1, 'red')
        unit.setPosition @map.size.w-100, height
        unit.setDirection -1
      @opponent.addUnit unit
    unit.addListener 'click', -> console.log 'click unit'
    @map.addChild unit


  update: (dt) ->
    if @refresh
      @refresh = false
      for u in @player.units
        if @player.id < @opponent.id
          u.objectDirection = 1
        else
          u.objectDirection = -1
        u.target = undefined
        u.sprite.play 'move'
      for u in @opponent.units
        if @player.id < @opponent.id
          u.objectDirection = -1
        else
          u.objectDirection = 1
        u.target = undefined
        u.sprite.play 'move'    

    if @player and @opponent
      for unit in @player.units
        if unit.life
          if unit.life <= 0 
            @map.removeChild unit
            @player.removeChild unit
            @refresh = true
        for enemy in @opponent.units
          if unit.inRange enemy
            console.log 'inrange'
            unit.attack enemy
            break
        if unit.inRange @opponent.mainBase
          console.log 'attack base'
          console.log @opponent.mainBase.id
          unit.attack @opponent.mainBase
      for unit in @opponent.units
        if unit.life
          if unit.life <= 0 
            @map.removeChild unit
            @opponent.removeChild unit
            @refresh = true
        for enemy in @player.units
          if unit.inRange enemy
            unit.attack enemy
            break
        if unit.inRange @player.mainBase
          console.log 'attack base2'
          unit.attack @player.mainBase

    super dt



  scroll: (dist) ->
    @map.position.x -= dist
    if @map.position.x > 0
      @map.position.x = 0
    else if @map.position.x < -@map.size.w + @canvas.width
      @map.position.x = -@map.size.w + @canvas.width
