class window.Building extends GameObject
  constructor: (playerId) ->
    super playerId

    sprite = new SpriteImage 'building.png'
    @addChild sprite

    # Building Stats
    @life = undefined
