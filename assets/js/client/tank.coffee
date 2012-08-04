class window.Tank extends Unit
  @coolDown: 12000
  @spLife: 500
  @spSpeed: 10
  @spDamage: 90
  @spRange: 120
  @spAs: 1500
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
    @life = Tank.spLife
    @moveSpeed = Tank.spSpeed
    @damage = Tank.spDamage
    @attackRange = Tank.spRange
    @attackSpeed = Tank.spAs
