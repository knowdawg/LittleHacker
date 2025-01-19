extends CharacterBody2D

@export var hasSpear : bool = true

@onready var sprite : Sprite2D = $GorgonSprite

func _process(_delta: float) -> void:
	if velocity.x > 0:
		pass
