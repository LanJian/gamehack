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

  dmgUp: ->
    console.log 'dmgup'
    Tank.spDamage += 8
    Jeep.spDamage += 5
    Soldier.spDamage += 2

  cdUp: ->
    Tank.coolDown -= 500
    Jeep.coolDown -= 200
    Soldier.coolDown -= 100

  speedUp: ->
    Tank.spSpeed += 2
    Jeep.spSpeed += 2
    Soldier.spSpeed += 2

  asUp: ->
    Tank.spAs -= 500
    Jeep.spAs -= 25
    Soldier.spAs -= 10

  lifeUp: ->
    Tank.spLife += 50
    Jeep.spLife += 25
    Soldier.spLife += 10

  rangeUp: ->
    Tank.spRange += 2
    Jeep.spRange += 3
    Soldier.spRange += 2

  Array::remove = (e) -> @[t..t] = [] if (t = @indexOf(e)) > -1
