extends Camera2D
class_name BigCamera

func _ready() -> void:
	Game.bigCamera = self

func reset():
	zoom = Vector2(1.0, 1.0)
	global_position = get_parent().global_position


var shake : float = 0.0
#var targetZoom := Vector2(10.0, 10.0)

func _process(delta: float) -> void:
	if shake > 0:
		shake = lerpf(shake, 0, 10.0 * delta)
		
		var xDis : float = randf_range(-shake, shake)
		var yDis : float = randf_range(-shake, shake)
		
		offset = Vector2(xDis, yDis)
	
	#if zoom != targetZoom:
		#zoom = lerp(zoom, targetZoom, 10.0 * delta)
	#
	#if Game.inHackMode:
		#targetZoom = Vector2(11.0, 11.0)
	#else:
		#targetZoom = Vector2(10.0, 10.0)

func set_shake(amount : float):
	shake = amount
	
func add_shake(amount : float):
	shake += amount

func set_min_shake(amount : float):
	if shake < amount:
		shake = amount
