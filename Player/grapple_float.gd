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
	if is_instance_valid(grappleTarget):
		grappleTarget.onPlayerStuckToMeWithGrapple()

func exit(_n):
	if is_instance_valid(grappleTarget):
		grappleTarget.onPlayerJumpOffMe()

func update_physics(delta):
	player.velocity = Vector2.ZERO
	if is_instance_valid(grappleTarget):
		player.global_position = grappleTarget.global_position
	player.move_and_slide()
	
	if playerStateMachine.getInputBuffer() == "Jump":
		var direction = Input.get_axis("Left", "Right")
		player.grappleBoost.x += direction * 50.0
		player.global_position += Vector2(Input.get_axis("Left", "Right"), -1.0) #For enemy Knockback
		
		weaponStateMachine.switchStates("Idle")
		trasitioned.emit(self, "GrappleJump")
		return
	
	if weaponStateMachine.inputBuffer == "Attack":
		player.global_position += Vector2(-player.getSpriteDirection(), -1.0) #For enemy Knockback
		
		weaponStateMachine.switchStates("GrappleAttack")
		trasitioned.emit(self, "GrappleAttack")
		return
