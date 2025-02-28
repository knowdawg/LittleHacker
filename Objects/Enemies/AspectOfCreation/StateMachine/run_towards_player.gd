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
	
	if sm.distToPlayer < 30:
		end = true
		t = lengthOfState - 0.6
		moveSpeed *= 1.5
		
		var r := randf()
		if r < sm.chanceToSlideAttack:
			
			call_deferred("switchToGroundSlideAttack")
		animator.play("GroundSlide")
	else:
		animator.play(animationName)
	
	
	if sm.dirToPlayer == sm.DIRECTION.LEFT:
		dirVec = Vector2(-1, 0);
	else:
		dirVec = Vector2(1, 0);

func update(delta):
	movement.move(dirVec, moveSpeed, delta)
	spriteDirector.updateDirection()
	
	t += delta
	if t > lengthOfState:
		trasitioned.emit(self, "Idle")
	
	if sm.distToPlayer < 25 and end == false:
		end = true
		var r := randf()
		var r2 = randi_range(0, 1)
		if r < sm.chanceToSlideAttack:
			if r2 == 0:
				trasitioned.emit(self, "SlideAttack")
				return
			if r2 == 1:
				trasitioned.emit(self, "GroundSlideAttack")
				return
		if r2 == 0:
			animator.play("Slide")
		if r2 == 1:
			animator.play("GroundSlide")
		t = lengthOfState - 0.6
	if end == true:
		moveSpeed = move_toward(moveSpeed, 0.0, delta * 3000.0)

func switchToGroundSlideAttack():
	trasitioned.emit(self, "GroundSlideAttack")
