extends State


@export var laserRaycast : RayCast2D
@export var laserVisual : Line2D
@export var laserContainer : Node2D
@export var blackHole : Sprite2D

@export var laserAttackComponent : AttackComponent
@export var laserHitbox : CollisionShape2D

@export var parent : CharacterBody2D
@export var animator : AnimationPlayer

var t = 0.0


func enter(_p):
	animator.play("MassiveLaser")
	t = 0.0
	laserRaycast.rotation_degrees = 0

func update_physics(delta):
	t += delta
	if t >= 0.7:
		updateLaserAttack()
		drawLaser()
	
	
	if t >= 2.4:
		trasitioned.emit(self, "Idle")
		return

func updateLaserAttack():
	if laserHitbox.shape is SegmentShape2D:
		var s : SegmentShape2D = laserHitbox.shape
		s.a = laserRaycast.position
		s.b = laserRaycast.get_collision_point() - parent.global_position
	else:
		printerr("Incorect Collision Shape For Remnant Crab Laser")

func drawLaser():
	if laserRaycast.is_colliding():
		laserContainer.position = -parent.global_position
		laserVisual.clear_points()
		laserVisual.add_point(laserRaycast.global_position)
		laserVisual.add_point(laserRaycast.get_collision_point())

func exit(_n):
	laserAttackComponent.disable()
	laserVisual.clear_points()
