extends State
class_name RemnantCrabRunToCenter

@export var parent : CharacterBody2D
@export var animator : AnimationPlayer

@export var maxSpeed : float = 100.0
@export var acceleration : float = 200.0

@export var leftRaycast : RayCast2D
@export var rightRaycast : RayCast2D

var t = 0.0
var switches : int = 0
var dir := Vector2.ZERO
var metTarget := false


func enter(_p):
	t = 0.0
	runVelocity = Vector2.ZERO
	metTarget = false
	animator.play("Run")
	
	updateDir()
	switches = 0

func updateDir():
	if leftRaycast.is_colliding() and rightRaycast.is_colliding():
		var leftDif = abs(parent.global_position.x - leftRaycast.get_collision_point().x)
		var rightDif = abs(parent.global_position.x - rightRaycast.get_collision_point().x)
		if leftDif > rightDif:#Move Left
			if dir != Vector2(-1.0, 0.0):
				switches += 1
			dir = Vector2(-1.0, 0.0)
		else:#move right
			if dir != Vector2(1.0, 0.0):
				switches += 1
			dir = Vector2(1.0, 0.0)
		

var runVelocity := Vector2.ZERO
func update_physics(delta):
	t += delta
	updateDir()
	
	runVelocity += dir * acceleration * delta
	runVelocity.x = clamp(runVelocity.x, -maxSpeed, maxSpeed)
	parent.velocity += runVelocity
	
	if switches >= 3:
		trasitioned.emit(self, "Idle")
	

func exit(_n):
	pass
	#skullSprite.rotation = 0.0
