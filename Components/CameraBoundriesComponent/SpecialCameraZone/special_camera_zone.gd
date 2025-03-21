extends Polygon2D
class_name SpecialCameraZone


#Returns the polygon in global position, taking into acount scale and position (does not take into acount rotation or skew)
func getGlobalPolygon():
	var newPoly : PackedVector2Array = []
	for p in polygon:
		newPoly.append(p * global_scale + global_position)
	return newPoly

func getCameraPostion(_targetPos : Vector2, _closestPoint : Vector2) -> Vector2:
	return Vector2.ZERO

func getGlobalSize() -> Vector2:
	var poly : PackedVector2Array = getGlobalPolygon()
	
	var greatestX : float
	var greatestY : float
	var leastX : float
	var leastY : float
	for p in poly:
		if greatestX == null:
			greatestX = p.x
		if greatestY == null:
			greatestY = p.y
		if leastX == null:
			leastX = p.x
		if leastY == null:
			leastY = p.y
		
		if p.x > greatestX:
			greatestX = p.x
		if p.y > greatestY:
			greatestY = p.y
		if p.x < leastX:
			leastX = p.x
		if p.y < leastY:
			leastY = p.y
		
	return Vector2(greatestX - leastX, greatestY - leastY)
