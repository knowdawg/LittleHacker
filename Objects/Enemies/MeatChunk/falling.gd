extends State

@export var animator : AnimationPlayer
@export var parent : MeatChunk

func enter(_p):
	animator.play("Spin")

func update(_delta):
	if parent.is_on_floor():
		trasitioned.emit(self, "OnGround")
		return
