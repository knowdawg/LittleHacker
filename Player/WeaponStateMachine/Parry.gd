extends State
class_name PlayerWeaponParry

@export var weaponAnimator : AnimationPlayer
@export var playerSprite : Sprite2D
@export var weaponSprite : Sprite2D
@export var player : Player
@export var weaponStateMachine : PlayerWeaponStateMachine
@export var playerStateMachine : PlayerStateMachine

var t = 0.4
func enter():
	t = 0.4
	weaponAnimator.play("Parry")
	player.setParry(true)
	playerStateMachine.enterParry()

func update(delta):
	weaponSprite.moveTowardsPlayerFast(delta)
	t -= delta
	if t <= 0.0:
		trasitioned.emit(self, "Idle")

func exit(_newState):
	player.setParry(false)
