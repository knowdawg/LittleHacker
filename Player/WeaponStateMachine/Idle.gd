extends State
class_name PlayerWeaponIdle

@export var weaponAnimator : AnimationPlayer
@export var playerSprite : Sprite2D
@export var weaponSprite : Sprite2D
@export var player : Player
@export var weaponStateMachine : PlayerWeaponStateMachine

func enter():
	weaponAnimator.play("Idle")

func update(delta):
	weaponSprite.moveTowardsPlayerNormal(delta)
	
	if weaponStateMachine.inputBuffer == "Parry" and player.canParry():
		trasitioned.emit(self, "Parry")
		return
	
	if weaponStateMachine.inputBuffer == "Attack":
		if Input.is_action_pressed("Down"):
			trasitioned.emit(self, "AttackDown")
			return
		elif Input.is_action_pressed("Up"):
			trasitioned.emit(self, "AttackVerticle")
			return
		else:
			trasitioned.emit(self, "AttackHorizontal")
			return
		
	if playerSprite.flip_h != weaponSprite.flip_h:
		trasitioned.emit(self, "SwapSides")
		return
	
