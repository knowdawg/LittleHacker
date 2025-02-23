extends State
class_name GenericTransitionState

@export var nextState : State
@export var length : float = 0.0

@export_group("Animation")
@export var animator : AnimationPlayer
@export var animationName : String = ""

var t : float = 0.0
func enter(prevState):
	t = 0.0
	if animator:
		animator.play(animationName)
	customEnter(prevState)

func customEnter(_prevState):
	pass

func update(delta):
	t += delta
	
	if t > length:
		beforeTransition()
		trasitioned.emit(self, nextState.name)
	
	customUpdate(delta)

func customUpdate(_delta):
	pass

func beforeTransition():
	pass
