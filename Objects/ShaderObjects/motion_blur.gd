extends CanvasLayer


func blur(position : Vector2):
	var p : Vector2 = position
	p.x /= get_viewport().size.x
	p.y /=  get_viewport().size.y
	$ColorRect.material.set_shader_parameter("blurCenter", p)
	$AnimationPlayer.play("Blur")

func passiveBlur(position : Vector2):
	var p : Vector2 = position
	p.x /= get_viewport().size.x
	p.y /=  get_viewport().size.y
	$ColorRect.material.set_shader_parameter("blurCenter", p)
	$AnimationPlayer.play("PassiveBlur")

func stopBlur():
	if $AnimationPlayer.current_animation == "Blur":
		return
	$AnimationPlayer.play("RESET")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Blur":
		$AnimationPlayer.play("RESET")
