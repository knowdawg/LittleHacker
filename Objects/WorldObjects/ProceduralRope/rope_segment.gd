extends Marker2D
class_name RopeSegment

var gravity : Vector2 = Vector2(0.0, 0.1)
var flexibility : float = 1.0
var parent : ProceduralRope

var externalForce : Vector2 = Vector2.ZERO
var a : Area2D
var collShape : SegmentShape2D

var prevPosition = Vector2.ZERO
func solvePosition(delta) -> void:
	var velocity = Vector2.ZERO
	velocity = global_position - prevPosition
	prevPosition = global_position
	
	#Apply outside forces
	if a:
		for b in a.get_overlapping_bodies():
			var disCurve : float
			disCurve = -global_position.distance_to(b.global_position) / (collShape.a.distance_to(collShape.b))
			disCurve += 1.0
			disCurve = clamp(disCurve, 0.0, 1.0)
			
			externalForce += (b.velocity * 0.01)# * disCurve)
			
			externalForce.y += 1.0
		

	#Delta time doesnt work perfectly yet
	position += velocity * flexibility + ((gravity + externalForce) * delta * 60.0 * Engine.time_scale)
	externalForce = Vector2.ZERO
	
	#Update the coliders
	if a:
		if myIndex < parent.ropeSegments.size() - 1 and myIndex != 0:
			collShape.a = 0.5 * (parent.ropeSegments[myIndex - 1].global_position - global_position)
			collShape.b =  0.5 * (parent.ropeSegments[myIndex + 1].global_position - global_position)

var myIndex : int
func _ready() -> void: #setup stuff
	myIndex = parent.ropeSegments.find(self)
	if myIndex == 0 or myIndex == parent.numOfSegments-1:
		return
	var area : Area2D = Area2D.new()
	area.set_collision_mask_value(3, true)
	area.set_collision_mask_value(4, true)
	area.set_collision_mask_value(1, false)
	var c = CollisionShape2D.new()
	var sh = SegmentShape2D.new()
	collShape = sh
	c.shape = sh
	add_child(area)
	a = area
	area.add_child(c)
