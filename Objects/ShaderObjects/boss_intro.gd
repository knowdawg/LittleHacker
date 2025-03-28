extends CanvasLayer

@export var shake : float = 3.0;
@export var title : String
@export var bossName : String

func _ready() -> void:
	%Title.text = "[center]" + title
	%Name.text = "[center]" + bossName

var timeLeft : float = 0.0
func play() -> void:
	timeLeft = 3.0
	$AnimationPlayer.play("Intro")

func _process(delta: float) -> void:
	timeLeft -= delta;
	if timeLeft > 0.2 and timeLeft < 2.8:
		Game.camera.set_shake(shake)
