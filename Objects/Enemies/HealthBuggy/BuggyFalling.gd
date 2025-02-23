extends State
class_name BuggyFalling

@export var sprite : Sprite2D
@export var animator : AnimationPlayer
@export var raycast : RayCast2D
@export var nextState : Array[State] = []

func enter(_prevState):
	animator.play("RESET")

func update(delta):
	sprite.rotate(delta * 15.0)
	
	if raycast.is_colliding():
		var r = randi_range(0, nextState.size() -1)
		trasitioned.emit(self, nextState[r].name)

func exit(_newState):
	sprite.rotation = 0
