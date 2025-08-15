extends Projectile
class_name CrystalEliteProjectile

var recal : bool = false
var recalVec := Vector2(0.0, 0.0)

func _process(delta: float) -> void:
	
	if recal:
		dirVector.x -= recalVec.x * delta * 2.0
		dirVector.x = clamp(dirVector.x, -1.0, 1.0)
		
		if dirVector.x > 0:
			$Transform/Sprite2D.flip_h = true
		if dirVector.x < 0:
			$Transform/Sprite2D.flip_h = false
	else:
		$Transform/Sprite2D.flip_h = flipH
	move(dirVector, speed, delta)
	
	if dirVector.x > 0:
		if $RightWall.is_colliding():
			delete()
			speed = 0.0
		
	if dirVector.x < 0:
		if $LeftWall.is_colliding():
			delete()
			speed = 0.0
	
	#if !$Grounded.is_colliding() or !$Grounded2.is_colliding():
		#delete()
	#else:
		#if $Grounded.is_colliding():
			#var p : Vector2 = $Grounded.get_collision_point()
	


func delete():
	speed *= 0.5
	$AfterImageComponent.setActive(false)
	$AttackComponent.call_deferred("disable")
	$AnimationPlayer.play("Delete")


func _on_attack_component_got_parried(_a) -> void:
	delete()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Delete":
		queue_free()
