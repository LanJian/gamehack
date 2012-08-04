class window.Unit extends Component
  constructor: () ->
    super()

    spriteSheet = new SpriteSheet 'hibiki.png', 1, 25

    sprite = new Sprite spriteSheet
    sprite.addAnimation 'idle', 0, 25, 24
    sprite.play 'idle'
    sprite.addListener 'click', (evt) ->
      console.log ['first sprite clicked', evt.x, evt.y, evt.target]
    sprite.addListener 'move', (evt) -> console.log 'move'

    test = new Sprite spriteSheet
    test.addAnimation 'idle', 0, 25, 40
    test.setPosition 100, 100
    test.play 'idle'

    @addChild test
    @addChild sprite

    @addListener 'click', (evt) ->
      console.log ['unit clicked', evt.x, evt.y, evt.target]
    @addListener 'mouseOut', ((evt) ->
      if this == evt.target
        console.log [evt.target, 'mouse out']).bind this
    @addListener 'mouseOver', ((evt) ->
      if this == evt.target
        console.log [evt.target, 'mouse over']).bind this
    @addListener 'mouseMove', -> console.log 'mouse move'
    @onKeyDown 65, -> console.log 'a pressed'

    setTimeout (( -> sprite.stop()).bind this), 5000
    setTimeout (( -> sprite.play()).bind this), 8000


  draw: (ctx) ->
    # test boundaries
    rect = new Rect @position.x, @position.y, @size.w, @size.h
    rect.draw ctx
    super ctx
