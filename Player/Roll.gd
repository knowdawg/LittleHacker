extends State
class_name SmallPlayerRoll

@export var animated_player_sprite : AnimationPlayer
@export var player : Player
@export var rollSpeedCurve : Curve
@export var rollSpeedMultiplier : float = 6000
@export var playerStateMachine : PlayerStateMachine
@export var hurtboxForIframes : HurtboxComponent
@export var weaponStateMachine : StateMachine

var rollTime : float = 0.6;
var t : float = 0.0;

var direction : float = 1.0

func update_physics(delta):
	var isDashParrying = weaponStateMachine.current_state is PlayerWeaponDashParry
	
	player.update_physics(delta, true, false)
	t += delta;
	var progress : float = t / rollTime
	var speed : float = rollSpeedCurve.sample(progress) * rollSpeedMultiplier * direction * delta
	player.dashV.x = speed
	
	if t <= 0.2:
		hurtboxForIframes.ift = 0.05
	
	if progress >= 0.75 and Input.get_axis("Left", "Right") != 0 and !isDashParrying:
		trasitioned.emit(self, "Run")
		return
	
	if progress >= 0.2 and playerStateMachine.inputBuffer == "Jump" and player.canCoyoteJump() == true and !isDashParrying:
		var dir = player.getSpriteDirection()
		if progress <= 0.3:
			player.rollJumpBoost.x = 45.0 * dir
		elif progress <= 0.5:
			player.rollJumpBoost.x = 35.0 * dir
		
		trasitioned.emit(self, "Jump")
		return
	
	if progress >= 1.0:
		if isDashParrying and player.is_on_floor():
			trasitioned.emit(self, "GroundParry")
		else:
			trasitioned.emit(self, "Idle")
		return

func enter(_prevState):
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
