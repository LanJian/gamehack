class window.Sprite extends Component
  constructor: () ->
    super()

    @spriteSheets = {}
    @animations = {}

    @playingAnimation = 'none'
    @isPlaying = false
    @loop = true

    @addListener 'spriteImageLoaded', @onSpriteImageLoaded.bind this

    @reset()


  addSpriteSheet: (id, spriteSheet) ->
    @spriteSheets[id] = spriteSheet


  onSpriteImageLoaded: (evt) ->
    found = false
    for key, val of @spriteSheets
      if val == evt.target
        found = true
        break
    if not found
      return

    # Set size
    w = h = 0
    for key, spr of @spriteSheets
      for f in spr.getData()
        if f.w > w
          w = f.w
        if f.h > h
          h = f.h
    @setSize w, h


  addAnimation: (id, spriteSheetId, startFrame, duration, fps=60) ->
    @animations[id] =
      spriteSheet: spriteSheetId
      startFrame: startFrame
      duration: duration
      frameInterval: 1000/fps


  reset: ->
    @frameIndex = 0
    @curInterval = 0

  playOnce: (id) ->
    if id and @playingAnimation != id
      @playingAnimation = id
      @reset()
      @loop = false

    @isPlaying = true


  play: (id) ->
    if id and @playingAnimation != id
      @playingAnimation = id
      @reset()
      @loop = true

    @isPlaying = true


  stop: ->
    @isPlaying = false


  update: (dt) ->
    anim = @animations[@playingAnimation]
    if not anim
      return
    spriteSheet = @spriteSheets[anim.spriteSheet]
    if spriteSheet and  @isPlaying and spriteSheet.isReady()
      @curInterval += dt
      if @curInterval >= anim.frameInterval
        @frameIndex++
        if (@frameIndex >= anim.duration) and not @loop
          @stop()
        @frameIndex = @frameIndex % anim.duration
        @curInterval = @curInterval % anim.frameInterval

    super dt


  draw: (ctx) ->
    anim = @animations[@playingAnimation]
    if not anim
      return
    spriteSheet = @spriteSheets[anim.spriteSheet]
    if spriteSheet and spriteSheet.isReady()
      f = spriteSheet.getData()[@frameIndex]
      dw = if @size.w == 0 then f.w else @size.w
      dh = if @size.h == 0 then f.h else @size.h
      ctx.drawImage spriteSheet.getImage(), f.x, f.y, f.w, f.h,
        @position.x, @position.y, dw, dh

    super ctx
