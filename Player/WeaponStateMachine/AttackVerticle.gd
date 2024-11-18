extends State
class_name PlayerWeaponAttackVerticle

@export var weaponAnimator : AnimationPlayer
@export var weaponSprite : Sprite2D
@export var playerSprite : Sprite2D
@export var player : Player
@export var weaponStateMachine : PlayerWeaponStateMachine
@export var playerStateMachine : PlayerStateMachine

@export var upAttackComponent : AttackComponent

var t = 0.0
func enter(_prevState):
	weaponAnimator.play("AttackVerticle")
	weaponSprite.flip_h = playerSprite.flip_h
	upAttackComponent.generateAttackID()
	t = 0.0

func update(delta):
	weaponSprite.moveTowardsPlayerFast(delta)
	
	t += delta
	
	if t < 0.4 and t > 0.3:
		upAttackComponent.enable()
	else:
		upAttackComponent.disable()
	
	if t <= 0.1:
		weaponSprite.flip_h = playerSprite.flip_h
	
	if weaponStateMachine.inputBuffer == "Parry" and player.canParry():
		if playerStateMachine.current_state is SmallPlayerRoll:
			trasitioned.emit(self, "DashParry")
		else:
			trasitioned.emit(self, "Parry")
		return
	
	if t >= 0.7:
		trasitioned.emit(self, "Idle")
