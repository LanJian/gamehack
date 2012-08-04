class window.Building extends GameObject
  constructor: (playerId) ->
    super playerId

    sprite = new SpriteImage 'building.png'
    console.log ['sprite', sprite.size.w, sprite.size.h]
    @addChild sprite

    # Building Stats
    @life = undefined
