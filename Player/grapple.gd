extends State
class_name PlayerGrapple

@export var playerStateMachine : PlayerStateMachine
@export var weaponStateMachine : PlayerWeaponStateMachine
@export var animationName : String = ""
@export var animator : AnimationPlayer
@export var player : Player
@export var playerSprite : Sprite2D

@export var velocityCurve : Curve
@export var grappleStickState : PlayerGrappleStick
@export var line : Line2D

@export var grappleLaunchSound : AudioStreamPlayer
@export var grappleGrapplingSound : AudioStreamPlayer
@export var grappleLand : AudioStreamPlayer

var target : Enemy
var angle : float

var t = 0.0

func enter(_prevState):
	player.v = Vector2.ZERO
	animator.play(animationName)
	t = 0.0
	
	grappleLaunchSound.play()
	grappleGrapplingSound.play()

func update_physics(delta):
	var f : float = 150.0
	var posDir = (player.global_position - target.global_position).normalized()
	
	t += delta * 3.0
	var c = velocityCurve.sample(t)
	player.global_position = player.global_position.move_toward(target.global_position, c * delta * 150.0)
	
	if posDir.x > 0:
		playerSprite.flip_h = false
	else:
		playerSprite.flip_h = true
	
	if playerStateMachine.getInputBuffer() == "Jump":
		weaponStateMachine.switchStates("Idle")
		player.grappleBoost *= 0.75 #minimize Grapple Jump Chaning wihtout outrigt removing it
		player.grappleBoost += -posDir * f * Vector2(0.5, 0.3)
		trasitioned.emit(self, "Jump")
		return
	
	if player.global_position.distance_to(target.global_position) < 2:
		player.global_position = target.global_position
		grappleStickState.grappleTarget = target
		trasitioned.emit(self, "GrappleStick")
		return
	
	if !target.canBeGrappledTo():
		weaponStateMachine.switchStates("Idle")
		player.grappleBoost /= 2.0 #minimize Grapple Jump Chaning wihtout outrigt removing it
		player.grappleBoost += -posDir * f * Vector2(0.5, 0.3)
		trasitioned.emit(self, "Fall")
		return

func update(_delta):
	if target:
		line.clear_points()
		line.add_point(target.global_position)
		line.add_point(player.global_position + Vector2(0.0, -1.0))

func exit(_n):
	line.clear_points()
	
	grappleGrapplingSound.stop()
	grappleLand.play()
