class window.SpriteImage extends Component
  constructor: (filename) ->
    super()
    @image = new Image
    @image.src = '/img/' + filename
    @image.onload = @onImageLoaded.bind this
    @loaded = false


  onImageLoaded: ->
    @loaded = true
    @setSize @image.width, @image.height
    console.log [@image, @size.w, @size.h]


  draw: (ctx) ->
    super ctx
    if @loaded
      ctx.drawImage @image, @position.x, @position.y,
        @size.w, @size.h
