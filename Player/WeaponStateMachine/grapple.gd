extends State
class_name PlayerWeaponGrapple

@export var weaponStateMachine : PlayerWeaponStateMachine
@export var playerStateMachine : PlayerStateMachine
@export var weaponAnimator : AnimationPlayer
@export var animationNameSucess : String = ""
@export var animationNameFail : String = ""
@export var weaponSprite : Sprite2D
@export var player : Player
@export var grappleState : PlayerGrapple

var target : Enemy
var angle : float
var sucess : bool = false
func enter(_prevState):
	var gm = player.get_global_mouse_position()#get_viewport().get_mouse_position()
	angle = (player.global_position - gm).angle()
	target = EnemyPositionManager.findGrappleTarget(player.global_position, angle, PI / 8.0, 100.0, true, true)
	
	weaponStateMachine.inputBuffer = ""
	
	if target:
		target.onSelectedForGrappleTarget()
		weaponAnimator.play(animationNameSucess)
		grappleState.target = target
		grappleState.angle = angle
		playerStateMachine.switchStates("Grapple")
		sucess = true
	else:
		weaponAnimator.play(animationNameFail)
		sucess = false
	
	t = 0.0
	
var t = 0.0
func update(delta):
	if !sucess:
		trasitioned.emit(self, "Idle")
		return
	
	weaponSprite.moveTowardsPlayerFast(delta)
	
	if target:
		
		weaponSprite.look_at(target.global_position)
		if weaponSprite.flip_h == false:
			weaponSprite.rotation += PI
	
	#if weaponStateMachine.inputBuffer == "Attack":
		#trasitioned.emit(self, "GrappleAttack")
		#return
	
	#if player.global_position.distance_to(target.global_position) < 1.0:
		#trasitioned.emit(self, "Idle")
		#return
	t += delta
	if t >= 0.1:
		if !playerStateMachine.inGrappleState():
			trasitioned.emit(self, "Idle")

func exit(_next):
	weaponSprite.rotation = 0.0
