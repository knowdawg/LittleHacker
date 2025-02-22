extends Sprite2D
class_name RopeRailing

var ropeIndex : int
var rope : ProceduralRope

var procRope = preload("res://Objects/WorldObjects/ProceduralRope/procedural_rope.tscn")

var offsetMultiplier : float = 1.0

func _process(_delta: float) -> void:
	if ropeIndex and rope:
		if ropeIndex < rope.ropeSegments.size() - 1 and ropeIndex != 0:
			#get slope and set rotation of railing acordingly
			var r1 = rope.ropeSegments[ropeIndex - 1].global_position
			var r2 = rope.ropeSegments[ropeIndex + 1].global_position
			var a : float = (r1 - r2).normalized().angle()
			rotation = a
			
			#offset in the corect direction
			var x = Vector2(-sin(a), cos(a)) * offsetMultiplier
			position = x * Vector2(0.5, 0.5) + x * texture.get_size() / 2.0
		else: #original ropes always point strait up so offset them acordingly
			position = Vector2(0.0, -1.0) * texture.get_size() / 2.0
	else:
		position = Vector2(0.0, -1.0) * texture.get_size() / 2.0

func _ready() -> void:
	if ropeIndex == 0:
		return
	
	if rope.railingsOnlyOnFront == false:
		randomize()
		if randf() > 0.5:
			offsetMultiplier = -1.0
	
	if rope.conectRailins == false:
		return
	#create a new rope and conect it to the prev rope
	var conectedRailing : RopeRailing = rope.railings[rope.railings.find(self) - 1]
	var sizeOfRope : float = global_position.distance_to(conectedRailing.global_position)
	var r = procRope.instantiate()
	r.ropeTexture = rope.railingRopeTexture
	r.numOfRailings = 0
	r.ropeWidth = 0.5
	r.startPoint = self
	r.endPoint = conectedRailing
	r.startPointLocked = true
	r.endPointLocked = true
	r.numOfSegments = sizeOfRope * 0.7
	r.ropeDis = 2.0
	r.flexibility = 1.0
	r.isColidable = false
	
	add_child(r)
	
