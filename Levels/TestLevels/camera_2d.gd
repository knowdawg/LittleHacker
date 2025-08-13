extends Camera2D
class_name SmallPlayerCamera

@export var cameraBounds : ProximityAreaComponent
@export var player : Player
var nodeToTrack : Node2D

var shake : float = 0.0

func setNodeToTrack(n : Node2D):
	nodeToTrack = n

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Game.camera = self
	Game.exitHackMode.connect(onHackModeExit)
	setNodeToTrack(player)

var targetZoom := Vector2(10.0, 10.0)

func _process(delta: float) -> void:
	if !is_instance_valid(nodeToTrack):
		setNodeToTrack(player)
	
	var p : CameraCoundriesComponent = cameraBounds.get_camera_bounds()
	if p:
		var targetPos = p.closest_rectangle_position(nodeToTrack.global_position)
		global_position = targetPos
	
	if shake > 0:
		shake = lerpf(shake, 0, 10.0 * delta)
		
		var xDis : float = randf_range(-shake, shake)
		var yDis : float = randf_range(-shake, shake)
		
		offset = Vector2(xDis, yDis)
	
	if zoom != targetZoom:
		zoom = lerp(zoom, targetZoom, 10.0 * delta)
	
	if Game.inHackMode:
		targetZoom = Vector2(11.0, 11.0)
	else:
		targetZoom = Vector2(10.0, 10.0)#Vector2(5.0, 5.0)#Vector2(10.0, 10.0)

func onHackModeExit():
	zoom = Vector2(14.0, 14.0)

func set_shake(amount : float):
	shake = amount
	
func add_shake(amount : float):
	shake += amount

func set_min_shake(amount : float):
	if shake < amount:
		shake = amount
