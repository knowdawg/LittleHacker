extends Line2D


@export var follow : Node2D
@export var size : float = 10.0
@export var hertz = 0.1

# Called every frame. 'delta' is the elapsed time since the previous frame.
var curT = 0.0
func _process(delta: float) -> void:
	curT += delta
	if curT >= hertz:
		curT -= hertz
		if !is_instance_valid(follow):
			queue_free()
		else:
			add_point(follow.global_position)
	
	if points.size() > size:
		remove_point(0)
