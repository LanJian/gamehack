class window.Soldier extends Unit
  constructor: (playerId, @objectId, @speed, color) ->
    if color == 'blue'
      spriteMap = { 'moving': (new SpriteSheet 'BlueSoldierMoving.png', 1, 6),
      'attacking' : (new SpriteSheet 'BlueSoldierAttacking.png', 1, 2)} 
    else 
      spriteMap = { 'moving': (new SpriteSheet 'RedSoldierMoving.png', 1, 6),
      'attacking' : (new SpriteSheet 'RedSoldierAttacking.png', 1, 2)} 

    super playerId, @objectId, spriteMap

    @sprite.addAnimation 'move', 'moving', 0, 5, 24
    @sprite.addAnimation 'attack', 'attacking', 0, 1, 12
    console.log @sprite.animations
    @addListener 'click', ((evt) ->
      @attack()).bind this

    @sprite.play 'move'
    
    # Unit Stats
    @life = 10
    @moveSpeed = 20
    @damage = 2
    @attackRange = 100
    @attackSpeed = 100
