extends State

@export var sm : AspectOfCreationStateMachine

@export var lengthOfState : float = 1.2
@export var speed : float = 240
@export var movement : MovementComponent
@export var spriteDirector : SpriteDirectorComponent

@export_group("Animation")
@export var animator : AnimationPlayer
@export var animationName : String = ""

var dirVec : Vector2
var t : float = 0.0
var moveSpeed
var end : bool = false
func enter(_prevState):
	end = false
	moveSpeed = speed
	t = 0.0
	
	animator.play(animationName)
	
	if sm.dirToPlayer == sm.DIRECTION.LEFT:
		dirVec = Vector2(1, 0);
	else:
		dirVec = Vector2(-1, 0);
		

func update(delta):
	movement.move(dirVec, moveSpeed, delta)
	spriteDirector.updateDirection()
	
	t += delta
	if t > lengthOfState:
		trasitioned.emit(self, "Idle")
	
	if t >= (lengthOfState - 0.6) and end == false:
		t = lengthOfState - 0.6
		end = true
		var r = randi_range(0, 1)
		if r == 0:
			animator.play("Slide")
		else:
			animator.play("GroundSlide")
	
	if end == true:
		moveSpeed = move_toward(moveSpeed, 0.0, delta * 3000.0)
