extends State
class_name PlayerWeaponAttackHorizontal

@export var attackTime : float = 0.7
@export var weaponAnimator : AnimationPlayer
@export var weaponSprite : Sprite2D
@export var playerSprite : Sprite2D
@export var player : Player
@export var weaponStateMachine : PlayerWeaponStateMachine
@export var playerStateMachine : PlayerStateMachine

@export var leftAttackComponent : AttackComponent
@export var rightAttackComponent : AttackComponent

@export var playerMovementCurve : Curve

var t = 0.0
func enter(_prevState):
	weaponAnimator.play("AttackHorizontal")
	weaponSprite.flip_h = playerSprite.flip_h
	t = 0.0
	leftAttackComponent.generateAttackID()
	rightAttackComponent.generateAttackID()


func update(delta):
	weaponSprite.moveTowardsPlayerFast(delta)
	
	if t < 0.2 and t > 0.1:
		if weaponSprite.flip_h == false:
			leftAttackComponent.enable()
		else:
			rightAttackComponent.enable()
	else:
		leftAttackComponent.disable()
		rightAttackComponent.disable()
	
	t += delta
	if t <= 0.1:
		weaponSprite.flip_h = playerSprite.flip_h
		if playerStateMachine.current_state is SmallPlayerRoll:
			trasitioned.emit(self, "DashAttack")
			return
		
	if weaponStateMachine.inputBuffer == "Parry":
		if playerStateMachine.current_state is SmallPlayerRoll:
			trasitioned.emit(self, "DashParry")
		else:
			trasitioned.emit(self, "Parry")
		return
	
	if t > attackTime:
		trasitioned.emit(self, "Idle")
