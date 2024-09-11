extends State

@export var attackLength : float = 0.0

@export_group("Next States")
@export var agroState : State

@export_group("Necesary Nodes")
@export var animator : AnimationPlayer

var t = 0.0
func enter():
	t = 0.0
	animator.play("Attack1")

func update(delta):
	t += delta
	if t >= attackLength:
		trasitioned.emit(self, agroState.name)
