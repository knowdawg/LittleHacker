extends State
class_name RemnantCrabLaserCrab

enum state {ToWall, StartLaser, FirstRun, SecoundRun, FinishUp, EndLaser}
var curState : state = state.ToWall

@export var leftRaycast : RayCast2D
@export var rightRaycast : RayCast2D
@export var laserRaycast : RayCast2D
@export var laserContainer : Node2D
@export var laserVisual : Line2D
@export var laserAnimator : AnimationPlayer
@export var blackHole : Sprite2D

@export var laserAttackComponent : AttackComponent
@export var laserHitbox : CollisionShape2D

@export var parent : RemnantCrab
@export var animator : AnimationPlayer

@export var skullSprite : Sprite2D
@export var cloak : Node2D
@export var maxRotation : float = 20.0

@export var maxSpeed : float = 100.0
@export var acceleration : float = 200.0

var t = 0.0
var length = 2.0
var dir := Vector2.ZERO
var metTarget := false

func enter(_p):
	curState = state.ToWall
	t = 0.0
	runVelocity = Vector2.ZERO
	metTarget = false

var runVelocity := Vector2.ZERO
var endLaserTimer = 0.0
func update_physics(delta):
	t += delta
	
	match curState:
		state.ToWall:
			animator.play("LaserRun")
			dir = Vector2(1.0, 0.0)
			runVelocity += dir * acceleration * delta
			
			if rightRaycast.is_colliding():
				parent.makeBlackHoleDangerous()
				laserAnimator.play("PrepLaser")
				curState = state.StartLaser
		state.StartLaser:
			runVelocity = runVelocity.move_toward(Vector2.ZERO, delta * 200.0)
			
			drawLaser()
			
			if abs(runVelocity.x) <= 0.1:
				laserAnimator.play("StartLaser")
				curState = state.FirstRun
				laserAttackComponent.readyAttack()
			
		state.FirstRun:
			dir = Vector2(-1.0, 0.0)
			runVelocity += dir * acceleration * delta
			
			drawLaser()
			updateLaserAttack()
			
			if leftRaycast.is_colliding():
				curState = state.SecoundRun
		state.SecoundRun:
			dir = Vector2(1.0, 0.0)
			runVelocity += dir * acceleration * delta
			
			drawLaser()
			updateLaserAttack()
			
			if rightRaycast.is_colliding():
				curState = state.FinishUp
		state.FinishUp:
			runVelocity = runVelocity.move_toward(Vector2.ZERO, delta * 200.0)
			
			drawLaser()
			updateLaserAttack()
			
			if abs(runVelocity.x) <= 0.1:
				laserAttackComponent.disable()
				laserAnimator.play("EndLaser")
				animator.play("LaserRunEnd")
				curState = state.EndLaser
				endLaserTimer = 0.0
				parent.makeBlackHoleSafe()
				return
		state.EndLaser:
			endLaserTimer += delta
			if endLaserTimer >= 0.3:
				trasitioned.emit(self, "Idle")
				return
	
	runVelocity.x = clamp(runVelocity.x, -maxSpeed, maxSpeed)
	
	
	var rot : float = (runVelocity.x / maxSpeed) * maxRotation
	skullSprite.rotation_degrees = rot
	cloak.rotation_degrees = rot / 4.0
	laserRaycast.rotation_degrees = runVelocity.x / 2.0#rot * 3.0
	
	parent.velocity += runVelocity
	
func updateLaserAttack():
	if laserHitbox.shape is SegmentShape2D:
		var s : SegmentShape2D = laserHitbox.shape
		s.b = laserRaycast.get_collision_point() - parent.global_position
	else:
		printerr("Incorect Collision Shape For Remnant Crab Laser")

func drawLaser():
	if laserRaycast.is_colliding():
		blackHole.visible = true
		laserContainer.position = -parent.global_position
		laserVisual.clear_points()
		laserVisual.add_point(laserRaycast.global_position)
		laserVisual.add_point(laserRaycast.get_collision_point())

func exit(_n):
	blackHole.visible = false
	laserAttackComponent.disable()
	laserVisual.clear_points()
	skullSprite.rotation = 0.0
	cloak.rotation_degrees = 0.0
