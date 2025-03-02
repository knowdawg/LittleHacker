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
func enter(_prevState):
	end = false
	moveSpeed = speed
	
	animator.play(animationName)
	
	if sm.dirToPlayer == sm.DIRECTION.LEFT:
		dirVec = Vector2(-1, 0);
	else:
		dirVec = Vector2(1, 0);

func update(delta):
	movement.move(dirVec, moveSpeed, delta)
	spriteDirector.updateDirection()
	
	if sm.distToPlayer < 15:
		trasitioned.emit(self, "Idle")
