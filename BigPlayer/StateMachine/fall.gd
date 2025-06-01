extends State
class_name BigPlayerFall

@export var animator : AnimationPlayer
@export var parent : BigPlayer

func enter(_p):
	animator.play("Idle")

func update_physics(delta: float) -> void:
	parent.fall(delta)
	parent.check_for_movement(delta)

func update(_delta):
	if parent.is_on_floor():
		trasitioned.emit(self, "Idle")
