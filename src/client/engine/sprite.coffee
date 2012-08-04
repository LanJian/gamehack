class window.Sprite extends Component
  constructor: (@spriteSheet) ->
    super()

    @animations = []
    @addAnimation 'all', 0, @spriteSheet.getNumFrames()

    @playingAnimation = @animations[0]
    @isPlaying = false

    @addListener 'spriteImageLoaded', @onSpriteImageLoaded.bind this

    @reset()


  onSpriteImageLoaded: (evt) ->
    if not evt.target == @spriteSheet
      return
    # Set size
    w = h = 0
    for f in @spriteSheet.getData()
      if f.w > w
        w = f.w
      if f.h > h
        h = f.h
    @setSize w, h



  addAnimation: (id, startFrame, duration, fps=60) ->
    @animations.push (
      id: id
      startFrame: startFrame
      duration: duration
      frameInterval: 1000/fps
    )


  reset: ->
    @frameIndex = 0
    @curInterval = 0


  play: (id) ->
    if id and @playingAnimation.id != id
      animation = (@animations.filter (anim) -> anim.id == id)[0]
      @playingAnimation = animation
      @reset()

    @isPlaying = true


  stop: ->
    @isPlaying = false


  update: (dt) ->
    if @isPlaying and @spriteSheet.isReady()
      @curInterval += dt
      if @curInterval >= @playingAnimation.frameInterval
        @frameIndex++
        @frameIndex = @frameIndex % @playingAnimation.duration
        @curInterval = @curInterval % @playingAnimation.frameInterval

    super dt


  draw: (ctx) ->
    if @spriteSheet.isReady()
      f = @spriteSheet.getData()[@frameIndex]
      dw = if @size.w == 0 then f.w else @size.w
      dh = if @size.h == 0 then f.h else @size.h
      ctx.drawImage @spriteSheet.getImage(), f.x, f.y, f.w, f.h,
        @position.x, @position.y, dw, dh

    super ctx
