extends Sprite2D
class_name RopeRailing

var ropeIndex : int
var rope : ProceduralRope

var procRope = preload("res://Objects/WorldObjects/ProceduralRope/procedural_rope.tscn")

func _process(_delta: float) -> void:
	if ropeIndex and rope:
		if ropeIndex < rope.ropeSegments.size() - 1 and ropeIndex != 0:
			#get slope and set rotation of railing acordingly
			var r1 = rope.ropeSegments[ropeIndex - 1].global_position
			var r2 = rope.ropeSegments[ropeIndex + 1].global_position
			var a : float = (r1 - r2).normalized().angle()
			rotation = a
			
			#offset in the corect direction
			var x = Vector2(-sin(a), cos(a))
			position = x * texture.get_size() / 2.0
		else: #original ropes always point strait up so offset them acordingly
			position = Vector2(0.0, -1.0) * texture.get_size() / 2.0
	else:
		position = Vector2(0.0, -1.0) * texture.get_size() / 2.0

func _ready() -> void:
	if ropeIndex == 0:
		return
	#create a new rope and conect it to the prev rope
	var conectedRailing : RopeRailing = rope.railings[rope.railings.find(self) - 1]
	var sizeOfRope : float = global_position.distance_to(conectedRailing.global_position)
	var r = procRope.instantiate()
	r.numOfRailings = 0
	r.ropeWidth = 0.5
	r.startPoint = self
	r.endPoint = conectedRailing
	r.startPointLocked = true
	r.endPointLocked = true
	r.numOfSegments = sizeOfRope * 0.5
	r.ropeDis = 2.5
	r.flexibility = 1.0
	r.isColidable = false
	
	add_child(r)
	
