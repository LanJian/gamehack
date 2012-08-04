class window.Building extends GameObject
  constructor: (playerId) ->
    super playerId

    sprite = new SpriteImage 'building.png'
    @addChild sprite

    # Building Stats
    @life = 1000


  takeDamage: (dmg) ->
    @life -= dmg
