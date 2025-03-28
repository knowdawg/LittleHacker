extends CharacterBody2D


@export var spriteAnimators : Array[AnimationPlayer]

func _ready() -> void:
	for a in spriteAnimators:
		a.play("Idle")
