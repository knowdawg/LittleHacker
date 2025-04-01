extends CharacterBody2D


@export var spriteAnimators : Array[AnimationPlayer]

func _ready() -> void:
	for a in spriteAnimators:
		a.play("Idle")

var t = 0.0
func _process(delta: float) -> void:
	t += delta
	position.x += sin(t)

#func _physics_process(delta: float) -> void:
	#if is_on_floor():
		#velocity.y = -145.0 * 0.5
	#
	#velocity.y += 500 * 0.5 * delta
	#
	#move_and_slide()
