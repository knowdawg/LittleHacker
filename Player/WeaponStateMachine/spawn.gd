extends State

var t = 0.7
@export var animator : AnimationPlayer
@export var weaponSprite : Sprite2D

func enter(_prevState):
	t = 0.7
	animator.play("SwordReform")

func update(delta):
	weaponSprite.moveTowardsPlayerFast(delta)
	t -= delta
	if t <= 0.0:
		trasitioned.emit(self, "Idle")
