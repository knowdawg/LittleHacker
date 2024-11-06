extends RichTextLabel

var isCrossed = false

func _ready() -> void:
	$AnimationPlayer.speed_scale = 10
	Game.enterHackMode.connect(reset)

func crossOut():
	isCrossed = true
	$CrossOutParticles.restart()
	$CrossOutParticles.emitting = true
	$AnimationPlayer.play("CrossOut")

func reset():
	isCrossed = false
	$AnimationPlayer.play("RESET")
