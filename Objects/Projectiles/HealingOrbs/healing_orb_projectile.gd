extends Node2D
class_name HealOrbProjectile

@export var speed : float = 100.0
@export var healAmount : float = 0.3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var vec = global_position - Game.player.global_position
	vec = -vec.normalized()
	position += vec * delta * speed
	
	if global_position.distance_to(Game.player.global_position) < 3.0:
		Game.player.heal(healAmount)
		queue_free()
