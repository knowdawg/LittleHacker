extends Sprite2D

@export var subScreen : SubViewport

# Called when the node enters the scene tree for the first time.
func _ready():
	Game.terminalOn.connect(bloomOn)
	Game.terminalOff.connect(bloomOff)
	if subScreen:
		texture = subScreen.get_texture()

func bloomOn():
	pass
	#$AnimationPlayer.play("BloomOn")
	#material.set_shader_parameter("bloomIntensity", 1.0)

func bloomOff():
	pass
	#material.set_shader_parameter("bloomIntensity", 0.0)
