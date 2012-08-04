class window.Building extends GameObject
  constructor: (playerId) ->
    super playerId
    @setSize 200, 300

    sprite = new Rect 0, 0, @size.w, @size.h
    @addChild sprite

    # Building Stats
    @life = undefined
