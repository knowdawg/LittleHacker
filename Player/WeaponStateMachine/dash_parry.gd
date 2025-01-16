extends State
class_name PlayerWeaponDashParry

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
	weaponAnimator.play("DashParry")
	
	#player.setParry(true)
	#playerStateMachine.enterParry()
	chainParry = false
	if weaponStateMachine.inputBuffer == "Parry":
		weaponStateMachine.inputBuffer = ""

func _ready():
	playerHurtBox.parry.connect(onParry)

func update(delta):
	if t > 0.6 and t < 1.0:
		weaponSprite.moveTowardsPlayerFast(delta)
	if t > 1.0:
		weaponSprite.moveTowardsPlayerNormal(delta)
	
	if weaponStateMachine.inputBuffer == "Parry" and chainParry == true:
		trasitioned.emit(self, "Parry")
	
	t += delta
	if t >= 0.3 and t <= 0.6:
		playerHurtBox.setParry(true, 2)
	else:
		playerHurtBox.setParry(false)
	
	if t >= 1.6:
		trasitioned.emit(self, "Idle")

var chainParry = false
func onParry(_attack : Attack):
	chainParry = true

func exit(_newState):
	#player.setParry(false)
	playerHurtBox.parrying = false
