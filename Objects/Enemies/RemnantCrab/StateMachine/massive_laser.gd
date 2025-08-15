extends State


@export var laserRaycast : RayCast2D
@export var laserVisual : Line2D
@export var laserContainer : Node2D
@export var blackHole : Sprite2D

@export var parent : CharacterBody2D
@export var animator : AnimationPlayer

var t = 0.0


func enter(_p):
	animator.play("MassiveLaser")
	t = 0.0
	laserRaycast.rotation_degrees = 0

func update_physics(delta):
	t += delta
	drawLaser()
	#if t >= 0.7:
	
	
	if t >= 6.1:
		trasitioned.emit(self, "Idle")
		return



func drawLaser():
	if laserRaycast.is_colliding():
		laserContainer.position = -parent.global_position
		laserVisual.clear_points()
		laserVisual.add_point(laserRaycast.global_position)
		laserVisual.add_point(laserRaycast.get_collision_point())

func exit(_n):
	laserVisual.clear_points()
