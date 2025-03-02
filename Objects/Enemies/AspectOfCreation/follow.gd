extends Marker2D

@export var parent : CharacterBody2D
@export var sprite : Sprite2D
# Called every frame. 'delta' is the elapsed time since the previous frame.
var active = false
func _process(_delta: float) -> void:
	if active:
		var pos : Vector2 = global_position
		if sprite.flip_h:
			pos.x -= startPos.x
			pos.x *= -1.0
			pos.x += startPos.x
		parent.global_position = pos

var startPos = Vector2.ZERO
func setActive(a : bool):
	#if a:
		#global_position = parent.global_position
		#startPos = parent.global_position
	active = a

func setStartingPos():
	global_position = parent.global_position
	startPos = parent.global_position
