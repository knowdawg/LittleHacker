extends Enemy

var startingPos : Vector2
var speed = 20.0

func customReady() -> void:
	startingPos = global_position
	

var v : Vector2 = Vector2.ZERO
func _physics_process(delta: float) -> void:
	if global_position.distance_to(startingPos) > 0.01:
		global_position = lerp(global_position, startingPos, delta * speed)
	
	velocity = Vector2.ZERO
	
	v = lerp(v, Vector2.ZERO, delta * 3.0)
	velocity += v
	
	move_and_slide()


func onSelectedForGrappleTarget():
	if Game.doesPlayerExist():
		var vec = (Game.player.global_position - global_position).normalized()
		applyForce(vec * 50.0)

func onPlayerJumpOffMe():
	if Game.doesPlayerExist():
		var vec = -(Game.player.global_position - global_position).normalized()
		applyForce(vec * 50.0)

func setStartingPos(p : Vector2):
	startingPos = p

func applyForce(f : Vector2):
	v += f
