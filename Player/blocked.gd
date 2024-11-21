extends State
class_name PlayerBlocked

@export var spriteAnimator : AnimationPlayer
@export var playerSprite : Sprite2D
@export var player : Player
@export var rollSpeedCurve : Curve
@export var rollSpeedMultiplier : float = 2000
@export var weaponSprite : Sprite2D

var stunLength = 0.5
var t = 0.0
var direction = 1.0

func enter(_prevState):
	t = 0.0
	spriteAnimator.play("Blocked")
	player.v.x = 0.0
	direction = weaponSprite.getDirection()
	
	if direction == 1:
		playerSprite.flip_h = false
	else:
		playerSprite.flip_h = true
		

func update_physics(delta):
	t += delta
	
	player.update_physics(delta, true, false)
	var progress : float = t / stunLength
	var speed : float = rollSpeedCurve.sample(progress) * rollSpeedMultiplier * direction * delta
	player.dashV.x = speed
	
	
	if t >= stunLength:
		trasitioned.emit(self, "Idle")

func exit(_nextState):
	player.dashV = Vector2.ZERO
