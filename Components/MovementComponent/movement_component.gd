extends Node
class_name MovementComponent

@export var parent : Node2D
@export var gravity : float = 0.0
var g = Vector2.ZERO

var falling : bool = false

var direction = 1
#Each Movement Function adds to velocities. Velocities are then added to the parents velocty.
#Velocities are cleared each frame.
var velocities : Array[Vector2] = []
var accelerations : Array[Vector2] = []
func _physics_process(delta: float) -> void:
	#Gravity
	g += Vector2(0.0, gravity)
	if parent is CharacterBody2D:
		if parent.is_on_floor():
			g = Vector2.ZERO
	velocities.append(g)
	
	#Force Vector
	force = lerp(force, Vector2.ZERO, delta * 10.0)
	velocities.append(force)
	
	var totalForce : Vector2 = Vector2.ZERO
	for v in velocities:
		if parent is CharacterBody2D:
			parent.velocity += v
			parent.move_and_slide()
			parent.velocity = Vector2.ZERO
		else:
			parent.position += v
		totalForce += v
	
	if totalForce.x >= 0:
		direction = 1
	else:
		direction = -1
	
	updateStatus(velocities)
	
	velocities.clear()

func updateStatus(velocitiesInput : Array[Vector2]):
	var summedVelocities = Vector2.ZERO
	for v in velocitiesInput:
		summedVelocities += v
	
	if summedVelocities.y < 0:
		falling = true
	else:
		falling = false

func getVelocity():
	var velocityTotal = Vector2.ZERO
	for v in velocities:
		velocityTotal += v
	return velocityTotal

func moveTowardsPlayer(speed, delta):
	var v = Vector2.ZERO
	if is_instance_valid(Game.player):
		var dirVec = (Game.player.global_position - parent.global_position).normalized()
		dirVec *= speed * delta
		v += dirVec
	velocities.append(v)

func moveTowardsPlayerX(speed, delta):
	var v = Vector2.ZERO
	if is_instance_valid(Game.player):
		if Game.player.global_position.x > parent.global_position.x:
			v.x = speed * delta
		else:
			v.x = -speed * delta
	velocities.append(v)

func moveTowardsPlayerY(speed, delta):
	var v = Vector2.ZERO
	if is_instance_valid(Game.player):
		if Game.player.global_position.y > parent.global_position.y:
			v.y = speed * delta
		else:
			v.y = -speed * delta
	velocities.append(v)

func moveAwayFromPlayer(speed, delta):
	var v = Vector2.ZERO
	if is_instance_valid(Game.player):
		var dirVec = (Game.player.global_position - parent.global_position).normalized()
		dirVec *= speed * delta
		v += -dirVec
	velocities.append(v)

func moveAwayFromPlayerX(speed, delta):
	var v = Vector2.ZERO
	if is_instance_valid(Game.player):
		if Game.player.global_position.x > parent.global_position.x:
			v.x = speed * delta
		else:
			v.x = -speed * delta
	velocities.append(-v)

func move(dir : Vector2, amplitude : float, delta):
	var v = dir * amplitude * delta
	velocities.append(v)

var force = Vector2.ZERO
func applyForce(forceVec : Vector2, forceAmplitude : float):
	force += forceVec.normalized() * forceAmplitude

func resetForces():
	force = Vector2.ZERO

func getVectorToPlayer(pos : Vector2, normalized : bool = true):
	if is_instance_valid(Game.player):
		var v = pos - Game.player.global_position
		if normalized:
			v = v.normalized()
		return v
	return Vector2.ZERO

func getVectorToPlayerX(pos : Vector2, normalized : bool = true):
	if is_instance_valid(Game.player):
		var v = pos - Game.player.global_position
		v.y = 0.0
		if normalized:
			v = v.normalized()
		return v
	return Vector2.ZERO

func setPosition(pos : Vector2):
	parent.position = pos
