extends Node
class_name ProceduralRope

@export var ropeColor : Color

@export_group("Rope Simulation")
@export var startPoint : Node2D
@export var endPoint : Node2D
@export var startPointLocked : bool = true
@export var endPointLocked : bool = false

@export var numOfSegments : float = 10
@export var ropeDis : float = 5
@export_range(0.0, 1.0) var flexibility : float = 1.0

@export var isColidable : bool = false

@onready var line = $Line2D
@onready var ropeSegments : Array[RopeSegment]

func _ready() -> void:
	if !startPoint or !endPoint:
		queue_free()
		return
	
	if isColidable:
		$StaticBody2D.set_collision_layer_value(2, true)
	else:
		$StaticBody2D.set_collision_layer_value(2, false)
	
	for i in range(numOfSegments):
		var r = RopeSegment.new()
		r.parent = self
		r.flexibility = flexibility
		r.global_position = startPoint.global_position + ((i / numOfSegments) * (endPoint.global_position - startPoint.global_position))
		ropeSegments.append(r)
		$RopeSegments.add_child(r)
		
		var c = CollisionShape2D.new()
		c.shape = SegmentShape2D.new()
		c.one_way_collision = true
		$StaticBody2D.add_child(c)
	
	line.default_color = ropeColor
	
	for i in range(100):
		solveRope()

func _process(delta: float) -> void:
	solveRope()
	
	line.clear_points()
	for s in ropeSegments:
		line.add_point(s.global_position)
	
	for c in $StaticBody2D.get_children().size() - 1:
		var col : CollisionShape2D = $StaticBody2D.get_child(c)
		var sh : SegmentShape2D = col.shape
		sh.a = ropeSegments[c].global_position
		sh.b = ropeSegments[c + 1].global_position

func solveRope():
	for s in ropeSegments:
		s.solvePosition()
	
	for i in range(25):
		solveContraints()

func solveContraints():
	if startPointLocked:
		ropeSegments[0].global_position = startPoint.global_position
	if endPointLocked:
		ropeSegments[numOfSegments - 1].global_position = endPoint.global_position
	
	for s in ropeSegments.size() - 1:
		var curSeg : RopeSegment = ropeSegments[s]
		var nextSeg : RopeSegment = ropeSegments[s+1]
		
		var dis = curSeg.global_position.distance_to(nextSeg.global_position)
		var difference = abs(dis - ropeDis)
		
		var segmentDir = Vector2.ZERO
		if dis > ropeDis:
			segmentDir = (curSeg.global_position - nextSeg.global_position).normalized()
		if dis < ropeDis:
			segmentDir = (nextSeg.global_position - curSeg.global_position).normalized()
		
		var moveAmount = segmentDir * difference
		
		curSeg.global_position -= moveAmount * 0.5
		nextSeg.global_position += moveAmount * 0.5
	
	if startPointLocked:
		ropeSegments[0].global_position = startPoint.global_position
	if endPointLocked:
		ropeSegments[numOfSegments - 1].global_position = endPoint.global_position
	
