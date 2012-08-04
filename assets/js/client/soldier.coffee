class window.Soldier extends Unit
  constructor: (playerId, @objectId, color) ->
    if color == 'blue'
      spriteMap = {
        'moving': (new SpriteSheet 'BlueSoldierMoving.png', 1, 6),
        'attacking' : (new SpriteSheet 'BlueTankAttacking.png', 1, 4)
      }
    else
      spriteMap = {
        'moving': (new SpriteSheet 'RedSoldierMoving.png', 1, 6),
        'attacking' : (new SpriteSheet 'RedTankAttacking.png', 1, 4)
      }

    super playerId, @objectId, spriteMap

    @sprite.addAnimation 'move', 'moving', 0, 5, 24
    @sprite.addAnimation 'attack', 'attacking', 0, 3, 24
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
