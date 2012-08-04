class window.HeavyTank extends Unit
  constructor: (playerId, @objectId, objectImageName, numRows, numColumns, @speed) ->
    super playerId, @objectId, objectImageName, numRows, numColumns, @speed

    # Unit Stats
    @life = 100
    @moveSpeed = 20
    @damage = 5
    @attackRange = 100
    @attackSpeed = 50
