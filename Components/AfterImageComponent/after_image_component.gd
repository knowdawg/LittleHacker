extends Node2D
class_name AfterImageComponent

@export var follow : Node2D
@export var sprite : Sprite2D
@export var frequency : float = 0.01
@export var fadeTime : float = 0.1
@export var startColor : Color = Color(1.0, 1.0, 1.0, 1.0)
@export var endColor : Color = Color(1.0, 1.0, 1.0, 0.0)

@export var active = true

var t = 0.0
func setActive(a : bool):
	active = a
	t = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position = Vector2.ZERO
	if active:
		t += delta
		if t > frequency:
			t -= frequency
			var s : Sprite2D = Sprite2D.new()
			s.texture = sprite.texture
			s.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
			s.flip_h = sprite.flip_h
			s.hframes = sprite.hframes
			s.vframes = sprite.vframes
			s.frame = sprite.frame
			s.scale = sprite.scale
			
			s.modulate = startColor
			add_child(s)
			#s.show_behind_parent = true
			s.global_position = follow.global_position
			var tw = create_tween()
			tw.tween_property(s, "modulate", endColor, fadeTime)
	for c in get_children():
		if c.modulate.a <= 0.01:
			c.queue_free()
