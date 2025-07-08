extends State
class_name RemnantCrabLaserCrab

enum state {ToWall, StartLaser, FirstRun, SecoundRun, FinishUp}
var curState : state = state.ToWall

@export var leftRaycast : RayCast2D
@export var rightRaycast : RayCast2D
@export var laserRaycast : RayCast2D
@export var laserVisual : Line2D
@export var laserAnimator : AnimationPlayer

@export var parent : CharacterBody2D
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
func update_physics(delta):
	t += delta
	
	match curState:
		state.ToWall:
			animator.play("LaserRun")
			dir = Vector2(1.0, 0.0)
			runVelocity += dir * acceleration * delta
			
			if rightRaycast.is_colliding():
				laserAnimator.play("PrepLaser")
				curState = state.StartLaser
		state.StartLaser:
			runVelocity = runVelocity.move_toward(Vector2.ZERO, delta * 200.0)
			
			drawLaser()
			
			if abs(runVelocity.x) <= 0.1:
				laserAnimator.play("StartLaser")
				curState = state.FirstRun
			
		state.FirstRun:
			dir = Vector2(-1.0, 0.0)
			runVelocity += dir * acceleration * delta
			
			drawLaser()
			
			if leftRaycast.is_colliding():
				curState = state.SecoundRun
		state.SecoundRun:
			dir = Vector2(1.0, 0.0)
			runVelocity += dir * acceleration * delta
			
			drawLaser()
			
			if rightRaycast.is_colliding():
				curState = state.FinishUp
		state.FinishUp:
			runVelocity = runVelocity.move_toward(Vector2.ZERO, delta * 200.0)
			
			drawLaser()
			
			if abs(runVelocity.x) <= 0.1:
				laserAnimator.play("EndLaser")
				trasitioned.emit(self, "Idle")
				return
	
	runVelocity.x = clamp(runVelocity.x, -maxSpeed, maxSpeed)
	
	
	var rot : float = (runVelocity.x / maxSpeed) * maxRotation
	skullSprite.rotation_degrees = rot
	cloak.rotation_degrees = rot / 2.0
	laserRaycast.rotation_degrees = runVelocity.x / 2.0#rot * 3.0
	
	parent.velocity += runVelocity
	

func drawLaser():
	if laserRaycast.is_colliding():
		laserVisual.clear_points()
		laserVisual.add_point(parent.global_position)
		laserVisual.add_point(laserRaycast.get_collision_point())

func exit(_n):
	laserVisual.clear_points()
	skullSprite.rotation = 0.0
	cloak.rotation_degrees = 0.0
