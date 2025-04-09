extends Camera2D
class_name SmallPlayerCamera

var shake : float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Game.camera = self

func _process(delta: float) -> void:
	if shake > 0:
		shake = lerpf(shake, 0, 10.0 * delta)
		
		var xDis : float = randf_range(-shake, shake)
		var yDis : float = randf_range(-shake, shake)
		
		offset = Vector2(xDis, yDis)
	
	if zoom != Vector2(12, 12):
		zoom = lerp(zoom, Vector2(12, 12), 10.0 * delta)

func set_shake(amount : float):
	shake = amount
	
func add_shake(amount : float):
	shake += amount
