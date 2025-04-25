extends GPUParticles2D

func _process(_delta: float) -> void:
	if is_instance_valid(Game.camera):
		global_position = Game.camera.global_position
	
	#if Game.doesPlayerExist():
		#global_position = Game.player.global_position
