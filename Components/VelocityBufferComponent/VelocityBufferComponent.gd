extends ColorRect

@export var thingToTrack : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	VelocityBuffer.shapes.append(self)

var prevPos = Vector2.ZERO
var curPos = Vector2.ZERO
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	prevPos = curPos
	curPos = thingToTrack.global_position
	var v : Vector2 = curPos - prevPos
	
	var red = v.x
	var green = v.y
	color = Color(red, green, 1.0, 1.0)

func _exit_tree() -> void:
	VelocityBuffer.shapes.remove_at(VelocityBuffer.shapes.find(self))
