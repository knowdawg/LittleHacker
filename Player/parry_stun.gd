extends State
class_name SmallPlayerParryStun

@export var player : Player
@export var rollSpeedCurve : Curve
@export var rollSpeedMultiplier : float = 6000;
@export var animator : AnimationPlayer

var rollTime : float = 0.3;
var t : float = 0.0;

var direction : float = 1.0

func enter(_prevState):
	if player.is_on_floor():
		animator.play("ParryStun")
	rollTime = player.parryStunTime
	t = 0.0
	if player.parriedAttack.attack_position > player.global_position:
		direction = 1.0
	else:
		direction = -1.0

func update_physics(delta):
	player.update_physics(delta, true, false)
	t += delta;
	var progress : float = t / rollTime
	var speed : float = rollSpeedCurve.sample(progress) * rollSpeedMultiplier * direction * delta
	player.dashV.x = -speed
	
	if progress >= 1.0:
		trasitioned.emit(self, "Idle")
		return

func exit(_newState):
	player.dashV.x = 0
