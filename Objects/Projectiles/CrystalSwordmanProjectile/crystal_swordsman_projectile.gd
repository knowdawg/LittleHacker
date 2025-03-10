extends Projectile


func _ready() -> void:
	$AttackComponent.gotParried.connect(parried)
	#$AfterImageComponent.flipH = flipH
	$Transform/Sprite2D.flip_h = flipH
	
	setFriendly(friendly)

func setFriendly(f : bool):
	if !f:
		$AttackComponent.set_collision_mask_value(4, false)
		$AttackComponent.set_collision_mask_value(3, true)
	elif f:
		$AttackComponent.set_collision_mask_value(4, true)
		$AttackComponent.set_collision_mask_value(3, false)
	$AttackComponent.generateAttackID()
	$AttackComponent.enable()

func _process(delta: float) -> void:
	move(dirVector, speed, delta)
	if !$Grounded.is_colliding() or !$Grounded2.is_colliding():
		delete()

func parried(_attack : Attack):
	call_deferred("setFriendly", !friendly)
	
	dirVector *= -1
	flipH = !flipH
	#$AfterImageComponent.flipH = flipH
	$Transform/Sprite2D.flip_h = flipH
	$AttackComponent.knockbackVector = dirVector
	$AnimationPlayer.play("RESET")
	$AfterImageComponent.setActive(true)
	speed = 90

func _on_envirement_detector_body_entered(_body: Node2D) -> void:
	delete()

func delete():
	speed = 0
	$AfterImageComponent.setActive(false)
	#$Sprite2D.visible = false
	#$PointLight2D.visible = false
	#$AttackComponent.call_deferred("disable")
	$AnimationPlayer.play("Shrink")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Shrink":
		queue_free()
