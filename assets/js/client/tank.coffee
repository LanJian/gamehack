class window.Tank extends Unit
  @coolDown: 10000
  constructor: (playerId, @objectId, color) ->
    if color == 'blue'
      spriteMap = {
        'moving': (new SpriteSheet 'BlueTankMoving.png', 1, 6),
        'attacking' : (new SpriteSheet 'BlueTankAttacking.png', 1, 4)
      }
    else
      spriteMap = {
        'moving': (new SpriteSheet 'RedTankMoving.png', 1, 6),
        'attacking' : (new SpriteSheet 'RedTankAttacking.png', 1, 4)
      }

    super playerId, @objectId, spriteMap

    @sprite.addAnimation 'move', 'moving', 0, 6, 24
    @sprite.addAnimation 'attack', 'attacking', 0, 4, 8
    console.log @sprite.animations
    @addListener 'click', ((evt) ->
      @attack()).bind this

    @sprite.play 'move'

    # Unit Stats
    @life = 500
    @moveSpeed = 10
    @damage = 50
    @attackRange = 150
    @attackSpeed = 2000
