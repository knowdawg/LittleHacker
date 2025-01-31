extends LightOccluder2D

@export var oneWay : bool = false

var verticies : PackedVector2Array = []
@onready var collisionShape : CollisionPolygon2D = $StaticBody2D/CollisionPolygon2D
@onready var staticBody : StaticBody2D = $StaticBody2D

func _ready() -> void:
	update()

func update():
	if occluder:
		verticies = occluder.polygon
		collisionShape.polygon = verticies
		if oneWay:
			staticBody.set_collision_layer_value(2, true)
			staticBody.set_collision_layer_value(1, false)
			collisionShape.one_way_collision = true
