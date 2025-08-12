extends CanvasLayer

@export var parent : Player

var prevP : Vector2 = Vector2.ZERO
func _process(_delta: float) -> void:
	var p : Vector2 = parent.get_global_transform_with_canvas().origin
	p.x /= get_viewport().size.x
	p.y /=  get_viewport().size.y
	
	if p != prevP:
		prevP = p
		$Vignette.material.set_shader_parameter("center", p)
