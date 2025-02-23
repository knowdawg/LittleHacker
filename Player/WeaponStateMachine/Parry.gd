extends State
class_name PlayerWeaponParry

@export var weaponAnimator : AnimationPlayer
@export var weaponSprite : Sprite2D
@export var player : Player
@export var weaponStateMachine : PlayerWeaponStateMachine
@export var playerStateMachine : PlayerStateMachine
@export var playerHurtBox : HurtboxComponent

var t = 0.0
func enter(_prevState):
	t = 0.0
	
	weaponAnimator.stop()
	weaponAnimator.play("Parry")
	
	player.setParry(true)
	playerStateMachine.enterParry()
	chainParry = false
	if weaponStateMachine.inputBuffer == "Parry":
		weaponStateMachine.inputBuffer = ""

func _ready():
	playerHurtBox.parry.connect(onParry)

func update(delta):
	if t < 0.1 and playerStateMachine.current_state is SmallPlayerRoll:
		trasitioned.emit(self, "DashParry")
		return
	
	if t < 0.35:
		weaponSprite.moveTowardsPlayerFast(delta)
	else:
		weaponSprite.moveTowardsPlayerNormal(delta)
	
	if weaponStateMachine.inputBuffer == "Parry" and chainParry == true:
		enter(null)
	
	if weaponStateMachine.inputBuffer == "HackAttack" and chainParry == true:
		if playerStateMachine.canHackAttack():
			trasitioned.emit(self, "HackAttack")
			return
	
	t += delta
	if t <= 0.2:
		playerHurtBox.setParry(true, 1)
	else:
		playerHurtBox.setParry(false)
	
	if t >= 0.4:
		trasitioned.emit(self, "Idle")

var chainParry = false
func onParry(_attack : Attack):
	chainParry = true

func exit(_newState):
	player.setParry(false)
	playerHurtBox.parrying = false
