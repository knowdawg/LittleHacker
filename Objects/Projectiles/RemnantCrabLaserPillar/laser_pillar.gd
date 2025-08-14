extends Projectile
class_name LaserPillar

var speedScale : float = 1.0

func activate():
	$Line2D.clear_points()
	
	$AnimationPlayer.speed_scale = speedScale
	$AnimationPlayer.play("Fire")

func setup():
	$Line2D.clear_points()
	$Line2D.add_point(Vector2(0.0, 0.0))
	if $RayCast2D.is_colliding():
		$Line2D.add_point($RayCast2D.get_collision_point() - global_position)
		$AttackComponent.scale.y = ($RayCast2D.get_collision_point() - global_position).y
	else:
		$Line2D.add_point(Vector2(0.0, -100.0))
		$AttackComponent.scale.y = 100.0

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
