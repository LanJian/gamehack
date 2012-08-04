class window.Unit extends GameObject
  constructor: (playerId, @objectId, spriteMap, animationMap, @speed) ->
    super playerId
    @objectDirection

    @sprite = new Sprite
    @sprite.addSpriteSheet key, spriteMap[key] for key,value of spriteMap

    @addChild @sprite

    # Unit Stats
    @life = undefined
    @moveSpeed = undefined
    @damage = undefined
    @attackRage = undefined
    @attackSpeed = undefined

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
    @move((@moveSpeed * dt)/1000)
    super dt

  setDirection: (direction) ->
    @objectDirection = direction

  attack: ->
    # Stop the think
    @objectDirection = 0
    @sprite.play 'attack'

