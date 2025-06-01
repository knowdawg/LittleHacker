extends State
class_name BigPlayerIdle

@export var animator : AnimationPlayer
@export var parent : BigPlayer

func enter(_p):
	animator.play("Idle")

func update_physics(delta: float) -> void:
	parent.fall(delta)
	parent.check_for_movement(delta)

func update(_delta):
	if abs(parent.velocity.x) > 0.0:
		trasitioned.emit(self, "Walk")
	
	if parent.velocity.y > 0:
		trasitioned.emit(self, "Fall")
	
	if Input.is_action_just_pressed("Jump"):
		trasitioned.emit(self, "Jump")
