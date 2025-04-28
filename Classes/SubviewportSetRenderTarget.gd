extends SubViewport

@export var renderTarget : UpdateMode = UpdateMode.UPDATE_WHEN_VISIBLE

func _process(_delta: float) -> void:
	#update move switching on launch for some reason
	if renderTarget == UpdateMode.UPDATE_ONCE:
		if render_target_update_mode > 1:
			render_target_update_mode = 1
	else:
		render_target_update_mode = renderTarget
