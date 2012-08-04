class window.Unit extends GameObject
  constructor: (playerId, @objectId, spriteMap, animationMap, @speed) ->
    super playerId
    @objectDirection

    @sprite = new Sprite
    @sprite.addSpriteSheet key, spriteMap[key] for key,value of spriteMap

    @addChild @sprite

    # Unit Stats
    @life = undefined
    @moveSpeed = undefined
    @damage = undefined
    @attackRange = undefined
    @attackSpeed = undefined

    @target = undefined
    @curInterval = 0


  move: (x) ->
    @position.x += (@objectDirection * x)

  update: (dt) ->
    @move((@moveSpeed * dt)/1000)
    if @target
      @curInterval += dt
      if @curInterval >= @attackSpeed
        @target.takeDamage @damage
        @curInterval = @curInterval % @attackSpeed
    super dt


  takeDamage: (dmg) ->
    @life -= dmg
    console.log [this, @life]

  setDirection: (direction) ->
    @objectDirection = direction

  attack: (target)->
    @target = target
    @objectDirection = 0
    @sprite.play 'attack'


  inRange: (enemy) ->
    dist = enemy.position.x - (@position.x + @size.w)
    if @position.x > enemy.position.x
      dist = @position.x - (enemy.position.x + enemy.size.w)
    if dist < 0
      dist = dist * -1
    if dist <= @attackRange
      return true
    return false
