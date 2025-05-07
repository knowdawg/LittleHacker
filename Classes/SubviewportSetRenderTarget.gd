extends SubViewport

@export var renderTarget : UpdateMode = UpdateMode.UPDATE_ONCE

func _ready() -> void:
	render_target_update_mode = renderTarget
