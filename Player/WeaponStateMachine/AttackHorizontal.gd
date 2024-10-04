extends State
class_name PlayerWeaponAttackHorizontal

@export var weaponAnimator : AnimationPlayer
@export var weaponSprite : Sprite2D
@export var playerSprite : Sprite2D
@export var player : Player
@export var weaponStateMachine : PlayerWeaponStateMachine

@export var leftAttackComponent : AttackComponent
@export var rightAttackComponent : AttackComponent

var t = 0.0
func enter(_prevState):
	weaponAnimator.play("AttackHorizontal")
	weaponSprite.flip_h = playerSprite.flip_h
	t = 0.4
	leftAttackComponent.generateAttackID()
	rightAttackComponent.generateAttackID()

func update(delta):
	weaponSprite.moveTowardsPlayerFast(delta)
	
	if t < 0.3 and t > 0.2:
		if weaponSprite.flip_h == false:
			leftAttackComponent.enable()
		else:
			rightAttackComponent.enable()
	else:
		leftAttackComponent.disable()
		rightAttackComponent.disable()
	
	t -= delta
	if t >= 0.3:
		weaponSprite.flip_h = playerSprite.flip_h
		
	if weaponStateMachine.inputBuffer == "Parry" and player.canParry():
		trasitioned.emit(self, "Parry")
		return
		
	if t <= 0.0:
		trasitioned.emit(self, "Idle")
