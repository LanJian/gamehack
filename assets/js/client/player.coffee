class window.Player
  constructor: (@id) ->
    @units = []
    @mainBase = null

  addUnit: (unit) ->
    @units.push unit

  addBuilding: (building) ->
    @mainBase = building
