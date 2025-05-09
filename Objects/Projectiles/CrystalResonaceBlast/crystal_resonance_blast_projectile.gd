extends Projectile

@export var greenProjectile : Resource
@export var redProjectile : Resource

enum colorChoices {PURPLE = 0, RED = 1, GREEN = 2}
var color : colorChoices = colorChoices.PURPLE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if color == colorChoices.PURPLE:
		pass
	elif color == colorChoices.RED:
		$Sprite2D.texture = redProjectile
	elif color == colorChoices.GREEN:
		$Sprite2D.texture = greenProjectile
	$AnimationPlayer.play("Resonate")
