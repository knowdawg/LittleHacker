extends State
class_name PlayerWeaponParry

@export var weaponAnimator : AnimationPlayer
@export var playerSprite : Sprite2D
@export var weaponSprite : Sprite2D
@export var player : Player
@export var weaponStateMachine : PlayerWeaponStateMachine
@export var playerStateMachine : PlayerStateMachine
@export var playerHurtBox : HurtboxComponent

var t = 0.0
func enter():
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
	weaponSprite.moveTowardsPlayerFast(delta)
	
	if weaponStateMachine.inputBuffer == "Parry" and chainParry == true:
		enter()
	
	t += delta
	if t <= 0.15:
		playerHurtBox.parrying = true
	else:
		playerHurtBox.parrying = false
	
	if t >= 0.4:
		trasitioned.emit(self, "Idle")

var chainParry = false
func onParry(_attack : Attack):
	chainParry = true

func exit(_newState):
	player.setParry(false)
	playerHurtBox.parrying = false
