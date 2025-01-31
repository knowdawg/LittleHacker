extends Sprite2D

@export var parent : Player

func _ready():
	position = parent.global_position
	Game.enterHackMode.connect(hide)
	Game.exitHackMode.connect(show)

func _process(_delta: float) -> void:
	global_position = (global_position * 4.0).round() / 4.0 #Make the position a bit snapy
	
	if Game.inHackMode == true:
		visible = false
	

func moveTowardsPlayerNormal(delta):
	position.x = lerp(position.x, parent.global_position.x, delta * 10)
	position.y = lerp(position.y, parent.global_position.y + 2.0, delta * 10)

func moveTowardsPlayerFast(_delta):
	position = parent.global_position + Vector2(0, 2.0)

func getDirection():
	if flip_h:
		return -1.0
	else:
		return 1.0
