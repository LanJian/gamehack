class window.Game extends Scene
  constructor: (@canvas, id, opponentId) ->
    super @canvas
    @player  = new Player id
    @opponent = new Player opponentId
    @refresh = false
    @endGame = false
    @size.w+500

    @init()


  reset: (playerId, opponentId) ->
    for unit in @player.units
      @map.removeChild unit
      @player.removeChild unit
    for unit in @opponent.units
      @map.removeChild unit
      @opponent.removeChild unit

    @map.removeChild @player.mainBase
    @map.removeChild @opponent.mainBase

    @removeChild @map
    @removeChild @uiPanel

    @player  = new Player (playerId || @player.id)
    @opponent = new Player (opponentId || @opponent.id)
    @refresh = false
    @endGame = false

    this.init()


  init: ->
    @map = new GameObject @player.id
    @map.setSize @size.w, @size.h

    bgSprite = new SpriteImage 'background.png'
    @map.addChild bgSprite

    @addBase @player.id
    @addBase @opponent.id

    if @player.id > @opponent.id
      @map.position.x = -@map.size.w + @canvas.width

    @onKeyDown 39, ( ->
      @scroll 6).bind this
    @onKeyDown 37, ( -> @scroll -6).bind this

    # UI
    @uiPanel = new Component 50, 5, @canvas.width-100, 50
    @uiPanel.addChild new SpriteImage 'TopBar.png'
    @spawnTank = new CooldownButton (new SpriteImage 'Tank.png'), 5000
    @spawnTank.setPosition 5, 0
    @spawnTank.clickAction = (() ->
      socket.emit('add unit', {'playerId': @player.id, 'type': 'tank'})
    ).bind this
    @spawnSoldier = new CooldownButton (new SpriteImage 'Soldier.png'), 5000
    @spawnSoldier.setPosition 65, 0
    @spawnSoldier.clickAction = (() ->
      socket.emit('add unit', {'playerId': @player.id, 'type': 'soldier'})
    ).bind this
    @spawnJeep = new CooldownButton (new SpriteImage 'Jeep.png'), 5000
    @spawnJeep.setPosition 125, 0
    @spawnJeep.clickAction = (() ->
      socket.emit('add unit', {'playerId': @player.id, 'type': 'jeep'})
    ).bind this
    @uiPanel.addChild @spawnTank
    @uiPanel.addChild @spawnSoldier
    @uiPanel.addChild @spawnJeep

    @addChild @map
    @addChild @uiPanel

  addBase: (playerId) ->
    height = 210
    building = new Building playerId
    building.setSize 226, 100
    # fine for now, but maybe use a Player object later?
    if playerId == @player.id
      if @player.id < @opponent.id
        building.setPosition 0, height
      else
        #building.setPosition @map.size.w-building.size.w, height
        building.setPosition 1214, height
      @player.addBuilding building
    else
      if @player.id > @opponent.id
        building.setPosition 0, height
      else
        #building.setPosition @map.size.w-building.size.w, height
        building.setPosition 1214, height
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
        else if type == 'jeep'
          unit = new Jeep(@player.id, 1.1, 'blue')
        else
          unit = new Soldier(@player.id, 1.1, 'blue')
        unit.setPosition 100, height
        unit.setDirection 1
      else
        if type == 'tank'
          unit = new Tank(@player.id, 1.1, 'red')
        else if type == 'jeep'
          unit = new Jeep(@player.id, 1.1, 'red')
        else
          unit = new Soldier(@player.id, 1.1, 'red')
        unit.setPosition @map.size.w-135, height
        unit.setDirection -1
      @player.addUnit unit
    else
      if @player.id > @opponent.id
        if type == 'tank'
          unit = new Tank(@opponent.id, 1.1, 'blue')
        else if type == 'jeep'
          unit = new Jeep(@player.id, 1.1, 'blue')
        else
          unit = new Soldier(@opponent.id, 1.1, 'blue')
        unit.setPosition 100, height
        unit.setDirection 1
      else
        if type == 'tank'
          unit = new Tank(@opponent.id, 1.1, 'red')
        else if type == 'jeep'
          unit = new Jeep(@player.id, 1.1, 'red')
        else
          unit = new Soldier(@opponent.id, 1.1, 'red')
        unit.setPosition @map.size.w-135, height
        unit.setDirection -1
      @opponent.addUnit unit
    unit.addListener 'click', -> console.log 'click unit'
    @map.addChild unit


  update: (dt) ->
    if @endGame
      return

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
          unit.attack @player.mainBase

      if !@endGame and @player.mainBase.life <= 0
        @endGame = true
        id1 = @player.id
        id2 = @opponent.id
        data = {}
        data[id1] = @player.mainBase.life
        data[id2] = @opponent.mainBase.life
        socket.emit('game over', data)

    super dt



  scroll: (dist) ->
    @map.position.x -= dist
    if @map.position.x > 0
      @map.position.x = 0
    else if @map.position.x < -@map.size.w + @canvas.width
      @map.position.x = -@map.size.w + @canvas.width
