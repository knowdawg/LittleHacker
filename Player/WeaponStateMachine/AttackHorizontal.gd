extends State
class_name PlayerWeaponAttackHorizontal

@export var animationName : String = ""
@export var recoveryAnimationName : String = ""
@export var attackTime : float = 0.7
@export var attackOverTime : float #Time when you can cancel into other attacks
@export var hitboxActiveTime : Array[Vector2] = []
@export var nextChainAttackState : State
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
	weaponAnimator.play(animationName)
	weaponSprite.flip_h = playerSprite.flip_h
	t = 0.0
	leftAttackComponent.generateAttackID()
	rightAttackComponent.generateAttackID()


func update(delta):
	if t < attackTime:
		weaponSprite.moveTowardsPlayerFast(delta)
	else:
		weaponSprite.moveTowardsPlayerNormal(delta)
	
	for v in hitboxActiveTime:
		if t > v.x and t < v.y:
			if weaponSprite.flip_h == false:
				leftAttackComponent.enable()
			else:
				rightAttackComponent.enable()
	
	for v in hitboxActiveTime:
		if t > v.x and t < v.y:
			break
		leftAttackComponent.disable()
		rightAttackComponent.disable()
	
	t += delta
	if t <= 0.1:
		weaponSprite.flip_h = playerSprite.flip_h
		if playerStateMachine.current_state is SmallPlayerRoll:
			trasitioned.emit(self, "DashAttack")
			return
	
	if t > attackOverTime:
		if weaponStateMachine.inputBuffer == "Attack" and Input.is_action_pressed("Down"):
			trasitioned.emit(self, "AttackDown")
		if weaponStateMachine.inputBuffer == "HackAttack" and playerStateMachine.canHackAttack():
			trasitioned.emit(self, "HackAttack")
			return
	
	if t > attackTime:
		if weaponStateMachine.inputBuffer == "Attack":
			if Input.is_action_pressed("Down"):
				trasitioned.emit(self, "AttackDown")
				return
			trasitioned.emit(self, nextChainAttackState.name)
			return
	
	if weaponStateMachine.inputBuffer == "Parry":
		if playerStateMachine.current_state is SmallPlayerRoll:
			trasitioned.emit(self, "DashParry")
		else:
			trasitioned.emit(self, "Parry")
		return
	
	if t > attackTime + 0.5:#Recoveries are 0.4 secound long
		trasitioned.emit(self, "Idle")
		return
	
	if t > attackTime:
		weaponAnimator.play(recoveryAnimationName)
		#trasitioned.emit(self, "Idle")
