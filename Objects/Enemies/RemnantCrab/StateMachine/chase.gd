extends State
class_name RemnantCrabChase

@export var parent : CharacterBody2D
@export var sm : RemnantCrabStateMachine
@export var animator : AnimationPlayer
@export var animationName := ""

@export var skullSprite : Sprite2D
@export var cloak : Node2D
@export var maxRotation : float = 20.0

@export var maxSpeed : float = 100.0
@export var acceleration : float = 200.0

enum style {ToPlayer, AwayFromPlayer, ChasePlayer}
@export var direction : style = style.ToPlayer

var t = 0.0
var length = 2.0
var dir := Vector2.ZERO
var metTarget := false

func enter(_p):
	t = 0.0
	runVelocity = Vector2.ZERO
	metTarget = false
	animator.play("Run")
	
	if direction == style.ChasePlayer:
		length = randf_range(0.5, 1.0)
	if direction == style.ToPlayer:
		dir = Vector2(sm.vectorToPlayer.x, 0.0).normalized()
	if direction == style.AwayFromPlayer:
		dir = -Vector2(sm.vectorToPlayer.x, 0.0).normalized()

var runVelocity := Vector2.ZERO
func update_physics(delta):
	t += delta
	
	if direction == style.ToPlayer:
		if abs(sm.xDisToPlayer) <= 10.0 or t >= 1.0:
			metTarget = true
		
		if metTarget:
			runVelocity = runVelocity.move_toward(Vector2.ZERO, delta * 100.0)
			if abs(runVelocity.x) <= 0.1:
				trasitioned.emit(self, "Idle")
				return
		else:
			runVelocity += dir * acceleration * delta
				
	if direction == style.AwayFromPlayer:
		if abs(sm.xDisToPlayer) >= 40.0 or t >= 1.0:
			metTarget = true
		
		if runVelocity.x > 0 and sm.nearRightWall:
			metTarget = true
		
		if runVelocity.x < 0 and sm.nearRightWall:
			metTarget = true
		
		if metTarget:
			runVelocity = runVelocity.move_toward(Vector2.ZERO, delta * 100.0)
			if abs(runVelocity.x) <= 0.1:
				trasitioned.emit(self, "Idle")
				return
		else:
			runVelocity += dir * acceleration * delta
	
	if direction == style.ChasePlayer:
		if t < length:
			dir = Vector2(sm.vectorToPlayer.x, 0.0).normalized()
			runVelocity += dir * acceleration * delta
		elif t > length:
			runVelocity = runVelocity.move_toward(Vector2.ZERO, delta * 100.0)
			if abs(runVelocity.x) <= 0.1:
				trasitioned.emit(self, "Idle")
				return
	
	runVelocity.x = clamp(runVelocity.x, -maxSpeed, maxSpeed)
	
	#print(runVelocity)
	
	var rot : float = (runVelocity.x / maxSpeed) * maxRotation
	skullSprite.rotation_degrees = rot
	cloak.rotation_degrees = rot / 2.0
	
	#animator.speed_scale = abs(float(runVelocity.x / maxSpeed))
	#animator.speed_scale = clamp(animator.speed_scale, 0.5, 1.0)
	
	parent.velocity += runVelocity
	#parent.move_and_slide()
	

func exit(_n):
	#animator.speed_scale = 1.0
	skullSprite.rotation = 0.0
