class window.Unit extends GameObject
  constructor: (playerId, @objectId, objectImageName, numRows, numColumns, @speed) ->
    super playerId
    @objectDirection

    spriteSheet = new SpriteSheet objectImageName, numRows, numColumns

    sprite = new Sprite spriteSheet
    sprite.addAnimation 'idle', 0, 25, 24
    sprite.play 'idle'

    @addChild sprite
    ###

    sprite.addListener 'click', (evt) ->
      console.log ['first sprite clicked', evt.x, evt.y, evt.target]
    sprite.addListener 'move', (evt) -> console.log 'move'

    @addChild sprite

    @addListener 'click', (evt) ->
      console.log ['unit clicked', evt.x, evt.y, evt.target]
    @addListener 'mouseOut', ((evt) ->
      if this == evt.target
        console.log [evt.target, 'mouse out']).bind this
    @addListener 'mouseOver', ((evt) ->
      if this == evt.target
        console.log [evt.target, 'mouse over']).bind this
    @addListener 'mouseMove', -> console.log 'mouse move'
    @onKeyDown 65, -> console.log 'a pressed'


    setTimeout (( -> sprite.stop()).bind this), 5000
    setTimeout (( -> sprite.play()).bind this), 8000

###

  move: (x) ->
      @position.x += (@objectDirection * x)

  update: (dt) ->
    @move((@speed * dt)/1000, 'right');
    super dt

  setDirection: (direction) ->
    @objectDirection = direction

