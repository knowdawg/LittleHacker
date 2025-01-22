extends State

@export var speed : float = 0.0
@export var movement : MovementComponent
@export var spriteDirector : SpriteDirectorComponent
@export var nextState : State
@export var animator : AnimationPlayer
@export var animationName : String = ""
@export var parent : CharacterBody2D
var t = 1.0

var dir : Vector2
func enter(_prevState):
	t = randf_range(0.5, 1.0)
	animator.play(animationName)
	dir = movement.getVectorToPlayerX(parent.global_position)

func update(delta):
	#movement.moveAwayFromPlayerX(speed, delta)
	movement.move(dir, speed, delta)
	spriteDirector.updateDirection()
	
	t -= delta
	if t <= 0.0:
		trasitioned.emit(self, nextState.name)
