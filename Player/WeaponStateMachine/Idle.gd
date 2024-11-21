extends State
class_name PlayerWeaponIdle

@export var weaponAnimator : AnimationPlayer
@export var playerSprite : Sprite2D
@export var weaponSprite : Sprite2D
@export var player : Player
@export var weaponStateMachine : PlayerWeaponStateMachine
@export var playerStateMachine : PlayerStateMachine

func enter(_prevState):
	weaponAnimator.play("Idle")

func update(delta):
	weaponSprite.moveTowardsPlayerNormal(delta)
	
	if weaponStateMachine.inputBuffer == "Parry":
		if playerStateMachine.current_state is SmallPlayerRoll:
			trasitioned.emit(self, "DashParry")
		else:
			trasitioned.emit(self, "Parry")
		return
	
	if weaponStateMachine.inputBuffer == "Attack":
		if Input.is_action_pressed("Down"):
			trasitioned.emit(self, "AttackDown")
			return
		elif Input.is_action_pressed("Up"):
			trasitioned.emit(self, "AttackVerticle")
			return
		elif playerStateMachine.current_state is SmallPlayerRoll:
			trasitioned.emit(self, "DashAttack")
			return
		else:
			trasitioned.emit(self, "AttackHorizontal")
			return
	
	if weaponStateMachine.inputBuffer == "HackAttack" and playerStateMachine.canHackAttack():
		trasitioned.emit(self, "HackAttack")
		return
	
	if playerSprite.flip_h != weaponSprite.flip_h:
		trasitioned.emit(self, "SwapSides")
		return
	
