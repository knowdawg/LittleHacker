extends State
class_name PlayerWeaponSwapSides

@export var weaponAnimator : AnimationPlayer
@export var weaponSprite : Sprite2D
@export var player : Player
@export var weaponStateMachine : PlayerWeaponStateMachine
@export var playerStateMachine : PlayerStateMachine

func enter(_prevState):
	weaponAnimator.play("Swap")

func update(delta):
	weaponSprite.moveTowardsPlayerNormal(delta)
	
	if weaponStateMachine.inputBuffer == "Parry":
		if false:#playerStateMachine.current_state is SmallPlayerRoll:
			trasitioned.emit(self, "DashParry")
		else:
			trasitioned.emit(self, "Parry")
		return
	
	if weaponStateMachine.inputBuffer == "Attack":
		if Input.is_action_pressed("Down"):
			trasitioned.emit(self, "AttackDown")
			return
		elif Input.is_action_pressed("Up"):
			trasitioned.emit(self, "AttackVerticle")
			return
		#elif playerStateMachine.current_state is SmallPlayerRoll:
			#trasitioned.emit(self, "DashAttack")
			#return
		else:
			trasitioned.emit(self, "AttackHorizontal")
			return
		
	if weaponStateMachine.inputBuffer == "HackAttack" and playerStateMachine.canHackAttack():
		trasitioned.emit(self, "HackAttack")
		return
		
	if weaponStateMachine.inputBuffer == "Grapple":
		trasitioned.emit(self, "Grapple")
		return

func _on_weapon_animator_animation_finished(anim_name):
	if anim_name == "Swap":
		trasitioned.emit(self, "Idle")

func exit(_newState):
	weaponSprite.flip_h = !weaponSprite.flip_h
	weaponSprite.frame = 0
