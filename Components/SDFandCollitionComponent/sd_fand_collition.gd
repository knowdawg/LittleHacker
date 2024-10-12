extends LightOccluder2D

var verticies : PackedVector2Array = []
@onready var collisionShape : CollisionPolygon2D = $StaticBody2D/CollisionPolygon2D

func _ready() -> void:
	update()

func update():
	if occluder:
		verticies = occluder.polygon
		collisionShape.polygon = verticies
