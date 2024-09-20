extends State
class_name PlayerWeaponAttackVerticle

@export var weaponAnimator : AnimationPlayer
@export var weaponSprite : Sprite2D
@export var playerSprite : Sprite2D
@export var player : Player
@export var weaponStateMachine : PlayerWeaponStateMachine

@export var upAttackComponent : AttackComponent

var t = 0.0
func enter():
	weaponAnimator.play("AttackVerticle")
	weaponSprite.flip_h = playerSprite.flip_h
	t = 0.4

func update(delta):
	weaponSprite.moveTowardsPlayerFast(delta)
	
	t -= delta
	
	if t < 0.3 and t > 0.2:
		upAttackComponent.enable()
	else:
		upAttackComponent.disable()
	
	if t >= 0.3:
		weaponSprite.flip_h = playerSprite.flip_h
	
	if weaponStateMachine.inputBuffer == "Parry" and player.canParry():
		trasitioned.emit(self, "Parry")
		return
	
	if t <= 0.0:
		trasitioned.emit(self, "Idle")
