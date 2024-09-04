extends Node2D
class_name CursorFollower

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#var gmp = EnemyHealthBarPositionManager.getActualGlobalMousePosition()
	#var closestHealthBar : EnemyHealthBar = EnemyHealthBarPositionManager.getClossestEnemyHealthBar(gmp)
	#if closestHealthBar:
		#var dis = closestHealthBar.follow.global_position.distance_to(gmp * 4.0)
		#if dis < 100:
			#position = lerp(position, closestHealthBar.follow.global_position / 4.0, delta * 30.0)
			#onTarget = true
			#rotation_degrees += delta * 200.0
			#if target:
				#if closestHealthBar != target:
					#locked = false
					#target.deactivate()
					#rotation_degrees = 0.0
					#target = closestHealthBar
			#else:
				#target = closestHealthBar
			##position = closestHealthBar.follow.global_position / 4.0
		#else:
			#if locked:
				#locked = false
				#target.deactivate()
			#rotation_degrees = 0.0
			#onTarget = false
			#position = lerp(position, gmp - Vector2(-0.5, 1.5), delta * 30.0)
			##position = gmp - Vector2(-0.5, 1.5)
	#else:
		#locked = false
		#onTarget = false
		#position = gmp - Vector2(-0.5, 1.5)
	#
	#
	#if onTarget:
		#if target:
			#if Input.is_action_just_pressed("LockOn") and locked == false:
				#target.activate()
				#locked = true
