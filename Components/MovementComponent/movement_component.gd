extends Node
class_name MovementComponent

@export var parent : Node2D
@export var gravity : float = 0.0
var g = Vector2.ZERO

#Each Movement Function adds to velocities. Velocities are then added to the parents velocty.
#Velocities are cleared each frame.
var velocities : Array[Vector2] = []
var accelerations : Array[Vector2] = []
func _physics_process(_delta: float) -> void:
	
	#Gravity
	g += Vector2(0.0, gravity)
	if parent is CharacterBody2D:
		if parent.is_on_floor():
			g = Vector2.ZERO
	velocities.append(g)
	
	for v in velocities:
		if parent is CharacterBody2D:
			parent.velocity += v
			parent.move_and_slide()
			parent.velocity = Vector2.ZERO
		else:
			parent.position += v
	velocities.clear()

func moveTowardsPlayer(speed, delta):
	var v = Vector2.ZERO
	if is_instance_valid(Game.player):
		var dirVec = (Game.player.global_position - parent.global_position).normalized()
		dirVec *= speed * delta
		v += dirVec
	velocities.append(v)
