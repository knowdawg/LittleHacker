extends SubViewport

@export var renderTarget : UpdateMode = UpdateMode.UPDATE_ONCE

@export var fps := 10.0

var t = 0.0
func _process(delta: float) -> void:
	if renderTarget == UpdateMode.UPDATE_ALWAYS or renderTarget == UpdateMode.UPDATE_WHEN_VISIBLE:
		t += delta
		var frame : float = 1.0 / fps
		if t >= frame:
			render_target_update_mode = SubViewport.UPDATE_ONCE
			t -= frame


func _ready() -> void:
	render_target_update_mode = renderTarget
	t = randf_range(0, 1.0 / fps)
