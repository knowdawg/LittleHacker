extends Area2D
class_name ProximityAreaComponent

#var a = null
#func get_camera_bounds():
	#var areas = get_overlapping_areas()
	#if areas.size() > 1:
		#return
	#for area in areas:
		#if area.get_parent() is CameraCoundriesComponent:
			#if a != area.get_parent():
				#a = area.get_parent()
				#Game.cameraBoundsChanged()
				#Game.currentCamera.position_smoothing_speed = 0.0
			#return area.get_parent()
	#return null

func is_player_inside():
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body is Player:
			return(true)
	return(false)

func get_player():
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body is Player:
			return body
	return null
