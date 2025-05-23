extends Sprite2D

@export var parent : Player
@export var audio : AudioStreamPlayer
@export var audio2 : AudioStreamPlayer

func _ready():
	Game.enterHackMode.connect(hide)
	Game.exitHackMode.connect(show)

func _process(_delta: float) -> void:
	global_position = (global_position * 4.0).round() / 4.0 #Make the position a bit snapy
	
	if Game.inHackMode == true:
		visible = false

func moveTowardsPlayerNormal(delta):
	position.x = lerp(position.x, parent.global_position.x - 2.0 * parent.getSpriteDirection(), delta * 10)
	position.y = lerp(position.y, parent.global_position.y + 2.0, delta * 10)

func moveTowardsPlayerFast(_delta):
	position = parent.global_position + Vector2(0, 2.0)

func getDirection():
	if flip_h:
		return -1.0
	else:
		return 1.0
		
func playSound():
	audio.pitch_scale = 2.0 + randf_range(-0.4, 0.4)
	audio.play()
	
func playSpinSound(pitch : float = 1.0):
	audio2.pitch_scale = pitch + randf_range(-pitch * 0.1, pitch * 0.1)
	audio2.play()
