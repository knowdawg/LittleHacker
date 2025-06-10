extends State

@export var animator : AnimationPlayer

var t := 0.0
func enter(_p):
	t = 0.0
	animator.play("LeaveBlock")
	
func update(delta):
	t += delta
	if t >= 0.1:
		trasitioned.emit(self, "Idle")
		return
