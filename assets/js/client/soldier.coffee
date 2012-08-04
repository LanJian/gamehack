class window.Soldier extends Unit
  @coolDown: 2000
  constructor: (playerId, @objectId, color) ->
    if color == 'blue'
      spriteMap = { 'moving': (new SpriteSheet 'BlueSoldierMoving.png', 1, 6),
      'attacking' : (new SpriteSheet 'BlueSoldierAttacking.png', 1, 2)}
    else
      spriteMap = { 'moving': (new SpriteSheet 'RedSoldierMoving.png', 1, 6),
      'attacking' : (new SpriteSheet 'RedSoldierAttacking.png', 1, 2)}

    super playerId, @objectId, spriteMap

    @sprite.addAnimation 'move', 'moving', 0, 6, 12
    @sprite.addAnimation 'attack', 'attacking', 0, 2, 12
    console.log @sprite.animations
    @addListener 'click', ((evt) ->
      @attack()).bind this

    @sprite.play 'move'

    # Unit Stats
    @life = 50
    @moveSpeed = 20
    @damage = 5
    @attackRange = 70
    @attackSpeed = 100
