class window.CooldownButton extends Component
  constructor: (@sprite, @cooldown) ->
    super()
    @addListener 'click', @onClickEvent.bind this
    @enabled = true
    @curInterval = 0
    @addChild @sprite


  onClickEvent: (evt) ->
    if @enabled
      @enabled = false
      @curInterval = 0
      @clickAction()


  doCoolDown: (cd) ->
    @enabled = false
    @cooldown = cd
    @curInterval = 0


  update: (dt) ->
    @curInterval += dt
    if @curInterval >= @cooldown
      @enabled = true
      @curInterval = @cooldown

    super dt


  draw: (ctx) ->

    ctx.save()
    ctx.globalAlpha = @curInterval / @cooldown
    super ctx
    ctx.restore()
