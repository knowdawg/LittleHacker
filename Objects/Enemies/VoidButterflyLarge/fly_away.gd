extends State
class_name FlyAway

@export var animator : AnimationPlayer
@export var animName : String
@export var sprite : Sprite2D
@export var spriteDirector : SpriteDirectorComponent
@export var parrent : Enemy
@export var curveY : Curve
@export var curveX : Curve
@export var curveSpeed = 1.0
@export var moveSpeedX := 30.0
@export var moveSpeedY := 70.0
@export var movement : MovementComponent

var t = 0.0
var v := Vector2.ZERO
var dir := Vector2.ZERO

func enter(_p):
	animator.play(animName)
	spriteDirector.lookAwayFromPlayer()
	if sprite.flip_h:
		dir = Vector2(1.0, -1.0)
	else:
		dir = Vector2(-1.0, -1.0)

func exit(_n):
	movement.applyForce(v, 100.0)

func update_physics(delta: float):
	t += delta
	v.y = curveY.sample(t * curveSpeed) * moveSpeedY
	v.x = curveX.sample(t * curveSpeed) * moveSpeedX
	v *= dir
	
	parrent.velocity = v
	parrent.move_and_slide()
