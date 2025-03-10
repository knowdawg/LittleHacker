extends State

@export var sm : AspectOfCreationStateMachine

@export var speed : float = 240
@export var movement : MovementComponent
@export var spriteDirector : SpriteDirectorComponent

@export_group("Animation")
@export var animator : AnimationPlayer
@export var animationName : String = ""

var dirVec : Vector2
var moveSpeed
var end : bool = false
var t = 0.0
func enter(_prevState):
	end = false
	moveSpeed = speed
	t = 0.0
	
	animator.play(animationName)
	
	if sm.isLeftBoundryColliding():
		dirVec = Vector2(1, 0);
	if sm.isRightBoundryColliding():
		dirVec = Vector2(-1, 0);
		

func update(delta):
	movement.move(dirVec, moveSpeed, delta)
	spriteDirector.updateDirection()
	
	t += delta
	if t >= 1.0:
		trasitioned.emit(self, "Idle")
		return
