extends CanvasLayer
class_name ScreenEffects


func blur(node : Node2D):
	var p : Vector2 = node.get_global_transform_with_canvas().origin
	p.x /= get_viewport().size.x
	p.y /=  get_viewport().size.y
	$Hack.material.set_shader_parameter("blurCenter", p)
	$HackAnimator.play("Blur")
	
func passiveBlur(node : Node2D):
	var p : Vector2 = node.get_global_transform_with_canvas().origin
	p.x /= get_viewport().size.x
	p.y /=  get_viewport().size.y
	$Hack.material.set_shader_parameter("blurCenter", p)
	$HackAnimator.play("PassiveBlur")

func stopBlur():
	if $HackAnimator.current_animation == "Blur":
		return
	$HackAnimator.play("RESET")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Blur":
		$HackAnimator.play("RESET")

func glitch():
	$GlitchAnimator.play("Glitch")

func superParry(node : Node2D):
	var p : Vector2 = node.get_global_transform_with_canvas().origin
	p.x /= get_viewport().size.x
	p.y /=  get_viewport().size.y
	$SuperParry.material.set_shader_parameter("blurCenter", p)
	$SuperParryAnimator.play("SuperParry")
	Game.camera.set_shake(3.0)
	Game.camera.zoom = Vector2(12.0, 12.0)
	Game.setTimeScale(0.1)

func showStatic():
	%StaticNoiseTimer.start()
	$StaticAnimator.play("FadeIn")

func _on_timer_timeout() -> void:
	%StaticNoise.visible = true
	%StaticNoiseSound.play()
