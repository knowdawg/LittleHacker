extends Projectile



func _process(delta: float) -> void:
	$Transform/Sprite2D.flip_h = flipH
	move(dirVector, speed, delta)
	#if !$Grounded.is_colliding() or !$Grounded2.is_colliding():
		#delete()
	#else:
		#if $Grounded.is_colliding():
			#var p : Vector2 = $Grounded.get_collision_point()

func delete():
	speed = 0
	$AfterImageComponent.setActive(false)
	print("Deleted")


func _on_attack_component_got_parried(_a) -> void:
	pass
	#delete()
