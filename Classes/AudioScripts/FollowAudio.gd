extends AudioStreamPlayer2D
class_name FollowAudio

@export var follow : Node2D

func _process(delta: float) -> void:
	if is_instance_valid(follow):
		global_position = follow.global_position
	
	customProcess(delta)

func customProcess(delta):
	pass
