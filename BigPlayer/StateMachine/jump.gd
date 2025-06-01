extends State

@export var parent : BigPlayer

func enter(_p):
	parent.jump()

func update_physics(delta: float) -> void:
	parent.fall(delta)
	parent.check_for_movement(delta)

func update(_delta):
	if parent.velocity.y > 0:
		trasitioned.emit(self, "Fall")
