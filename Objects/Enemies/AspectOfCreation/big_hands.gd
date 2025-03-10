extends Sprite2D

@export var spriteToMirror : Sprite2D

func _process(_delta: float) -> void:
	flip_h = spriteToMirror.flip_h


func fadeIn():
	$BigHandsAnimator.play("FadeIn")

func fadeOut():
	if material.get_shader_parameter("progess") <= 0.99:
		$BigHandsAnimator.play("FadeOut")
		
