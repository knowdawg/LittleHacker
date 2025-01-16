extends State
class_name playerWeaponDashAttack

@export var attackTime : float = 0.7
@export var weaponAnimator : AnimationPlayer
@export var weaponSprite : Sprite2D
@export var playerSprite : Sprite2D
@export var player : Player
@export var weaponStateMachine : PlayerWeaponStateMachine
@export var playerStateMachine : PlayerStateMachine

@export var leftAttackComponent : AttackComponent
@export var rightAttackComponent : AttackComponent


var t = 0.0
func enter(_prevState):
	weaponAnimator.play("DashAttack")
	weaponSprite.flip_h = playerSprite.flip_h
	t = 0.0
	leftAttackComponent.generateAttackID()
	rightAttackComponent.generateAttackID()


func update(delta):
	if t >= 0.7 and t < 0.9:
		weaponSprite.moveTowardsPlayerFast(delta)
	if t >= 0.9:
		weaponSprite.moveTowardsPlayerNormal(delta)
	
	if t > 0.7 and t < 0.8:
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
	
	if t > 1.2:
		if weaponStateMachine.inputBuffer == "Attack":
			if Input.is_action_pressed("Down"):
				trasitioned.emit(self, "AttackDown")
				return
			else:
				trasitioned.emit(self, "AttackHorizontal")
	
	if weaponStateMachine.inputBuffer == "Parry":
		if playerStateMachine.current_state is SmallPlayerRoll:
			trasitioned.emit(self, "DashParry")
		else:
			trasitioned.emit(self, "Parry")
		return
	
	if t > attackTime:
		trasitioned.emit(self, "Idle")
