extends Polygon2D
class_name CameraCoundriesComponent


var polygonTransorm : PackedVector2Array = []
@export var cameraSize : Vector2 = Vector2(128.0, 72.0)
var shrunkenPolygon : PackedVector2Array = []

# Current position of the rectangle's center
var current_position: Vector2

# Speed of the rectangle's movement (units per second)
var move_speed: float = 200.0

# Function to shrink an axis-aligned polygon by a given amount
func shrink_polygon(polygon_points: PackedVector2Array, shrink_x: float, shrink_y: float) -> PackedVector2Array:
	var shrunken_polygon = PackedVector2Array()
	
	# Iterate through each vertex of the polygon
	for i in range(polygon_points.size()):
		var prev_point = polygon_points[(i - 1 + polygon_points.size()) % polygon_points.size()]
		var curr_point = polygon_points[i]
		var next_point = polygon_points[(i + 1) % polygon_points.size()]
		
		# Determine the direction to shrink for the current vertex
		var dx = 0.0
		var dy = 0.0
		
		# Handle horizontal edges
		if curr_point.y == prev_point.y:
			# Shrink vertically
			dy = -shrink_y if curr_point.x > prev_point.x else shrink_y
		elif curr_point.y == next_point.y:
			# Shrink vertically
			dy = -shrink_y if curr_point.x < next_point.x else shrink_y
		
		# Handle vertical edges
		if curr_point.x == prev_point.x:
			# Shrink horizontally
			dx = -shrink_x if curr_point.y < prev_point.y else shrink_x
		elif curr_point.x == next_point.x:
			# Shrink horizontally
			dx = -shrink_x if curr_point.y > next_point.y else shrink_x
		
		# Shrink the current point
		var shrunken_point = curr_point + Vector2(dx, dy)
		
		shrunken_polygon.append(shrunken_point)
	
	$Shrink.polygon = shrunken_polygon
	return shrunken_polygon

# Function to find the closest rectangle center position inside the polygon
func closest_rectangle_position(target_position: Vector2) -> Vector2:
	# Compute the valid region for the rectangle's center
	var valid_region = shrunkenPolygon
	var modifiedTarget : Vector2 = target_position
	
	for z in specialZones:
		if is_point_in_polygon(target_position, z.getGlobalPolygon()):
			var closestPoint = closest_point_on_polygon(target_position, z.getGlobalPolygon())
			modifiedTarget = z.getCameraPostion(target_position, closestPoint)
	
	# Check if the target position is inside the valid region
	if is_point_in_polygon(modifiedTarget, valid_region):
		return modifiedTarget
	
	# Find the closest point on the valid region's boundary to the target position
	return closest_point_on_polygon(modifiedTarget, valid_region)

# Function to check if a point is inside a polygon
func is_point_in_polygon(point: Vector2, polygon_points: PackedVector2Array) -> bool:
	var inside = false
	var n = polygon_points.size()
	for i in range(n):
		var j = (i + 1) % n
		var p1 = polygon_points[i]
		var p2 = polygon_points[j]
		if ((p1.y > point.y) != (p2.y > point.y)) and \
		   (point.x < (p2.x - p1.x) * (point.y - p1.y) / (p2.y - p1.y) + p1.x):
			inside = not inside
	return inside

# Function to find the closest point on a polygon to a target point
func closest_point_on_polygon(target: Vector2, polygon_points: PackedVector2Array) -> Vector2:
	var closest_point = Vector2.ZERO
	var min_distance = INF
	
	for i in range(polygon_points.size()):
		var p1 = polygon_points[i]
		var p2 = polygon_points[(i + 1) % polygon_points.size()]
		
		# Find the closest point on the edge (p1, p2)
		var edge = p2 - p1
		var t = (target - p1).dot(edge) / edge.dot(edge)
		t = clamp(t, 0.0, 1.0)
		var point_on_edge = p1 + t * edge
		
		# Check if this is the closest point so far
		var distance = point_on_edge.distance_to(target)
		if distance < min_distance:
			min_distance = distance
			closest_point = point_on_edge
	
	return closest_point


var specialZones : Array[SpecialCameraZone] = []

func _ready():
	for c in get_children():
		if c is SpecialCameraZone:
			specialZones.append(c)
	
	for p in polygon:
		var newP : Vector2 = p * scale + position
		polygonTransorm.append(newP)
		
	var s = get_viewport_rect().size
	shrunkenPolygon = shrink_polygon(polygonTransorm, cameraSize.x / 2.0, cameraSize.y / 2.0)
	
	#generateLineSegments()
	visible = false
	$Area2D/CollisionPolygon2D.polygon = polygon
	
