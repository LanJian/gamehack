class window.Player
  constructor: (@id) ->
    @units = []

  addUnit: (unit) ->
    @units.push unit
