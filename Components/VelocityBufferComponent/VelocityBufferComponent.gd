extends ColorRect

@export var thingToTrack : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	VelocityBuffer.shapes.append(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var red = -clamp(thingToTrack.velocity.x / 200.0, -0.5, 0.5)
	red = process2(delta)
	var blue = 1.0
	if red < 0:
		blue = 0.2
	if red != 0:
		color = Color(red + 0.5, 1.0, blue, 1.0)
	else:
		color = Color(0.5, 0.0, 0.0, 1.0)
	

#postion delta
var prevPos : Vector2 = Vector2.ZERO
func process2(delta: float):
	var posDiff = global_position - prevPos
	prevPos = global_position

	var red = -clamp(posDiff.x * delta * 20.0, -0.5, 0.5)
	return red

func _exit_tree() -> void:
	VelocityBuffer.shapes.remove_at(VelocityBuffer.shapes.find(self))
