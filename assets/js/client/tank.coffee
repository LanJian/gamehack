class window.Tank extends Unit
  constructor: (playerId, @objectId, @speed) ->
    spriteMap = { 'moving': new SpriteSheet 'BlueTankMoving.png', 1, 6}

    super playerId, @objectId, spriteMap

    # Unit Stats
    @life = 100
    @moveSpeed = 30
    @damage = 5
    @attackRange = 100
    @attackSpeed = 50
