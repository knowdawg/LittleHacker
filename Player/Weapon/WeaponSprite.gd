extends Sprite2D

@export var parent : Player

func _ready():
	position = parent.global_position
	Game.enterHackMode.connect(hide)
	Game.exitHackMode.connect(show)

func _process(_delta: float) -> void:
	if Game.inHackMode == true:
		visible = false
	
	if flip_h == true:
		$LightOccluder2D.scale.x = -1
	else:
		$LightOccluder2D.scale.x = 1

func moveTowardsPlayerNormal(delta):
	position.x = lerp(position.x, parent.global_position.x, delta * 10)
	position.y = lerp(position.y, parent.global_position.y, delta * 10)

func moveTowardsPlayerFast(_delta):
	position = parent.global_position
