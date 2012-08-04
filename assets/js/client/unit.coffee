class window.Soldier extends Unit
  constructor: (playerId, @objectId, objectImageName, numRows, numColumns, @speed) ->
    super playerId, @objectId, objectImageName, numRows, numColumns, @speed

    # Unit Stats
    @life = 100
    @moveSpeed = 10
    @damage = 5
    @attackRange = 50
    @attackSpeed = 50
