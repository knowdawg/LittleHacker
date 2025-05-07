extends HackCommandComponent

@export var projectile : PackedScene
@export var projectileLocation : Node2D

func executeHack():
	var p = projectile.instantiate()
	Game.addProjectile(p)
	p.global_position = projectileLocation.global_position
