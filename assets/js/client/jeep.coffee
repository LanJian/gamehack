class window.Jeep extends Unit
  @coolDown: 5500
  constructor: (playerId, @objectId, color) ->
    if color == 'blue'
      spriteMap = {
        'moving': (new SpriteSheet 'BlueJeepMoving.png', 1, 6),
        'attacking' : (new SpriteSheet 'BlueJeepAttacking.png', 1, 6)
      }
    else
      spriteMap = {
        'moving': (new SpriteSheet 'RedJeepMoving.png', 1, 6),
        'attacking' : (new SpriteSheet 'RedJeepAttacking.png', 1, 6)
      }

    super playerId, @objectId, spriteMap

    @sprite.addAnimation 'move', 'moving', 0, 6, 24
    @sprite.addAnimation 'attack', 'attacking', 0, 6, 10
    console.log @sprite.animations

    @sprite.play 'move'

    # Unit Stats
    @life = 200
    @moveSpeed = 50
    @damage = 10
    @attackRange = 100
    @attackSpeed = 250
