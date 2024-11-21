extends State

@export var nextState : State

@export var animator : AnimationPlayer
@export var animationName : String
@export var animationLength : float

var t = 0.0
func enter(_prevState):
	animator.play(animationName)

func update(delta):
	t += delta
	
	
	
	if t >= animationLength:
		trasitioned.emit(self, nextState.name)
