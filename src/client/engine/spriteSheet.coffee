class window.SpriteSheet
  constructor: (@filename, @rows, @cols) ->
    @data = []
    @image = new Image
    @image.src = '../resources/' + @filename
    @image.onload = @onImageLoaded.bind this
    @loaded = false


  onImageLoaded: ->
    width = @image.width
    height = @image.height
    cellWidth = width/@cols
    cellHeight = height/@rows

    for i in [0..@rows-1]
      for j in [0..@cols-1]
        @data.push (
          x: j*cellWidth
          y: i*cellHeight
          w: cellWidth
          h: cellHeight
        )

    @loaded = true
    Event.dispatchEvent(
      type: 'spriteImageLoaded'
      origin: this
      target: this
      x: 0
      y: 0)


  getNumFrames: ->
    @data.length


  getData: ->
    @data


  getImage: ->
    @image


  isReady: ->
    @loaded
