extends State
class_name PlayerAttackDown

@export var weaponAnimator : AnimationPlayer
@export var weaponSprite : Sprite2D
@export var playerSprite : Sprite2D
@export var player : Player
@export var weaponStateMachine : PlayerWeaponStateMachine
@export var playerStateMachine : PlayerStateMachine

@export var downAttackComponent : AttackComponent

var t = 0.0
func enter(_prevState):
	weaponAnimator.play("AttackDown")
	weaponSprite.flip_h = playerSprite.flip_h
	downAttackComponent.generateAttackID()
	t = 0.4

func update(delta):
	weaponSprite.moveTowardsPlayerFast(delta)
	
	t -= delta
	
	if t < 0.3 and t > 0.2:
		downAttackComponent.enable()
	else:
		downAttackComponent.disable()
	
	if weaponStateMachine.inputBuffer == "Parry":
		if playerStateMachine.current_state is SmallPlayerRoll:
			trasitioned.emit(self, "DashParry")
		else:
			trasitioned.emit(self, "Parry")
		return
	
	if t >= 0.3:
		weaponSprite.flip_h = playerSprite.flip_h
	if t <= 0.0:
		trasitioned.emit(self, "Idle")
