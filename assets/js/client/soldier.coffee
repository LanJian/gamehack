class window.Soldier extends Unit
  @coolDown: 2000
  @spLife: 100
  @spSpeed: 20
  @spDamage: 8
  @spRange: 110
  @spAs: 200
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
    @life = Soldier.spLife
    @moveSpeed = Soldier.spSpeed
    @damage = Soldier.spDamage
    @attackRange = Soldier.spRange
    @attackSpeed = Soldier.spAs

    console.log ['spawn: ', this]
