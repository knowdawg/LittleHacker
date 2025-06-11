extends State

@export var animator : AnimationPlayer

var t := 0.0
func enter(_p):
	t = 0.0
	animator.play("Stagger")

func update(delta):
	t += delta
	
	if t >= 2.0:
		trasitioned.emit(self, "Idle")
