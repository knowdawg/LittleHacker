extends State
class_name PlayerWeaponHackAttack

@export var attackTime : float = 0.7
@export var weaponAnimator : AnimationPlayer
@export var weaponSprite : Sprite2D
@export var playerSprite : Sprite2D
@export var player : Player
@export var weaponStateMachine : PlayerWeaponStateMachine
@export var playerStateMachine : PlayerStateMachine
@export var playerHurtBox : HurtboxComponent

@export var leftAttackComponent : AttackComponent
@export var rightAttackComponent : AttackComponent

func leaveState():
	trasitioned.emit(self, "Idle")

var t = 0.0
func enter(_prevState):
	playerStateMachine.switchStates("HackAttack")
	weaponAnimator.play("HackAttack")
	weaponSprite.flip_h = playerSprite.flip_h
	t = 0.0
	leftAttackComponent.generateAttackID()
	rightAttackComponent.generateAttackID()

func update(delta):
	if playerStateMachine.current_state is PlayerHackMode:
		return
	elif !playerStateMachine.current_state is PlayerHackAttack:
		trasitioned.emit(self, "Idle")
		return
	
	weaponSprite.moveTowardsPlayerNormal(delta)
	
	if t < 0.8 and t > 0.5:
		if weaponSprite.flip_h == false:
			leftAttackComponent.enable()
		else:
			rightAttackComponent.enable()
		
		#playerHurtBox.setParry(true, 1)
		
	else:
		leftAttackComponent.disable()
		playerHurtBox.setParry(false)
	
	t += delta
	if t <= 0.1:
		weaponSprite.flip_h = playerSprite.flip_h
	
	if t > attackTime:
		trasitioned.emit(self, "Idle")

func exit(_nextState):
	playerHurtBox.setParry(false)
	weaponSprite.visible = true
	leftAttackComponent.call_deferred("disable")
	rightAttackComponent.call_deferred("disable")
