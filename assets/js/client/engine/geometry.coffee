class window.Rect extends Component
  constructor: (@x, @y, @w, @h, @color='black') ->
    super @x, @y, @w, @h

  containsPoint: (x, y) ->
    x >= @x and x <= @x + @w and
      y >= @y and y <= @y + @h

  draw: (ctx) ->
    ctx.fillStyle = @color
    ctx.beginPath()
    ctx.rect @x, @y, @w, @h
    ctx.closePath()
    ctx.fill()
    super ctx
