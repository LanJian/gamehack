class window.Player
  constructor: (@id) ->
    @units = []
    @mainBase = null

  addUnit: (unit) ->
    @units.push unit

  addBuilding: (building) ->
    @mainBase = building

  removeChild: (childToRemove) ->
    @units.remove childToRemove

  Array::remove = (e) -> @[t..t] = [] if (t = @indexOf(e)) > -1
