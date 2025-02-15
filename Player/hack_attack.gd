extends State
class_name PlayerHackAttack

@export var animator : AnimationPlayer
@export var scaleAnimator : AnimationPlayer
@export var player : Player
@export var hurtboxComponent : HurtboxComponent

@export_group("Curve Arguments")
@export var movementCurve : Curve
@export var stateLength : float = 1.0;
@export var speedMultiplier : float = 100
var t : float = 0.0;

var direction : float = 1.0

func update_physics(delta):
	player.update_physics(delta, true, false)
	t += delta;
	var progress : float = t / stateLength
	var speed : float = movementCurve.sample(progress) * speedMultiplier * direction * delta
	player.dashV.x = speed
	
	if t >= stateLength:
		trasitioned.emit(self, "Idle")
	
	if hurtboxComponent.parryForgivenesTimer.time_left > 0:
		hurtboxComponent.damageStuff()
		hurtboxComponent.parryForgivenesTimer.stop()

func enter(_prevState, speedUp : bool = false):
	t = 0.0;
	player.v.x = 0;
	animator.play("HackAttack")
	scaleAnimator.play("HackAttack")
	
	if speedUp == true:
		t = 0.1
		animator.seek(0.1)
		scaleAnimator.seek(0.1)
	
	if player.facingRight():
		direction = 1
		return
	if !player.facingRight():
		direction = -1
		return

func exit(_newState):
	player.dashV = Vector2.ZERO
