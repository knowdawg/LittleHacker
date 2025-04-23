extends State
class_name PlayerGrappleStick

@export var player : Player
@export var playerStateMachine : PlayerStateMachine
@export var weaponStateMachine : PlayerWeaponStateMachine

@export var animator : AnimationPlayer
@export var animationName : String

var grappleTarget : Enemy

var t = 0.0
func enter(_prev):
	animator.play(animationName)
	t = 0.0

func update_physics(delta):
	player.velocity = Vector2.ZERO
	if is_instance_valid(grappleTarget):
		player.global_position = grappleTarget.global_position
	player.move_and_slide()
	
	if playerStateMachine.getInputBuffer() == "Jump":
		weaponStateMachine.switchStates("Idle")
		trasitioned.emit(self, "GrappleJump")
		return
	
	if weaponStateMachine.inputBuffer == "Attack":
		weaponStateMachine.switchStates("GrappleAttack")
		trasitioned.emit(self, "GrappleAttack")
		return
