class window.Lifebar extends Component
  constructor: () ->
    super()
    @lifebarRed = new Rect 20, -20, 180, 10, 'red'
    @lifebarGreen = new Rect 20, -20, 180, 10, 'yellow'
    this.addChild @lifebarRed
    this.addChild @lifebarGreen


  updateLife: (currentLife, totalLife) ->
    @lifebarGreen.size.w = currentLife / totalLife * 180
