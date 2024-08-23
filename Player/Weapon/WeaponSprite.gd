extends Sprite2D

@export var parent : Player

func _ready():
	position = parent.global_position

func moveTowardsPlayerNormal(delta):
	position.x = lerp(position.x, parent.global_position.x, delta * 10)
	position.y = lerp(position.y, parent.global_position.y, delta * 10)

func moveTowardsPlayerFast(_delta):
	#position.x = lerp(position.x, parent.global_position.x, delta * 40)
	#position.y = lerp(position.y, parent.global_position.y, delta * 40)
	position = parent.global_position
