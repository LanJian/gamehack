class window.Jeep extends Unit
  @coolDown: 7000
  @spLife: 200
  @spSpeed: 50
  @spDamage: 25
  @spRange: 140
  @spAs: 600
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
    @life = Jeep.spLife
    @moveSpeed = Jeep.spSpeed
    @damage = Jeep.spDamage
    @attackRange = Jeep.spRange
    @attackSpeed = Jeep.spAs
