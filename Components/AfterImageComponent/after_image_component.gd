extends Node

@export var follow : Node2D
@export var texture : Texture
@export var frequency : float = 0.01
@export var fadeTime : float = 0.1
@export var flipH : float = false

var active = true

var t = 0.0
func setActive(a : bool):
	active = a
	t = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if active:
		t += delta
		if t > frequency:
			t -= frequency
			var s : Sprite2D = Sprite2D.new()
			s.texture = texture
			s.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
			s.flip_h = flipH
			add_child(s)
			s.global_position = follow.global_position
			var tw = create_tween()
			tw.tween_property(s, "modulate", Color(1.0, 1.0, 1.0, 0.0), fadeTime)
	for c in get_children():
		if c.modulate.a <= 0.01:
			c.queue_free()
