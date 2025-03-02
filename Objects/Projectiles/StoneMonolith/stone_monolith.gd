extends Projectile

func _ready() -> void:
	$AnimationPlayer.play("Rise")

func _process(delta: float) -> void:
	move(dirVector, speed, delta)

func _on_envirement_detector_body_entered(_body: Node2D) -> void:
	if destroyOnTerrain:
		$AttackComponent.call_deferred("disable")
		delete()

func delete():
	speed = 0
	$AfterImageComponent.setActive(false)
	$AnimationPlayer.play("Delete")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Delete":
		queue_free()


func _on_attack_component_got_parried(_attack) -> void:
	delete()
