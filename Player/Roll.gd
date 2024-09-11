extends State
class_name SmallPlayerRoll

@export var animated_player_sprite : AnimationPlayer
@export var player : Player
@export var rollSpeedCurve : Curve
@export var rollSpeedMultiplier : float = 6000;
@export var playerStateMachine : PlayerStateMachine
@export var hurtboxForIframes : HurtboxComponent

var rollTime : float = 0.6;
var t : float = 0.0;

var direction : float = 1.0

func update_physics(delta):
	player.update_physics(delta, true, false)
	t += delta;
	var progress : float = t / rollTime
	var speed : float = rollSpeedCurve.sample(progress) * rollSpeedMultiplier * direction * delta
	player.dashV.x = speed
	
	if t <= 0.2:
		hurtboxForIframes.ift = 0.05
	
	if progress >= 0.75 and Input.get_axis("Left", "Right") != 0:
		trasitioned.emit(self, "Run")
	
	if progress >= 1.0:
		trasitioned.emit(self, "Idle")
		return

func enter():
	t = 0.0;
	player.v.x = 0;
	animated_player_sprite.play("Roll")
	
	direction = Input.get_axis("Left", "Right")
	if direction != 0:
		if direction > 0:
			direction = 1
			if direction > player.v.x:
				player.v.x = 0
			return
		if direction < 0:
			direction = -1
			if direction < player.v.x:
				player.v.x = 0
			return;
	
	if player.facingRight():
		direction = 1
		return
	if !player.facingRight():
		direction = -1
		return

func exit(_newState):
	player.dashV = Vector2.ZERO
