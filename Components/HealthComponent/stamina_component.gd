extends HealthComponent
class_name StaminaComponent

@export var maxStamina : float
@export var staminaRegenPerSecound : float
@export var hurtboxComponent : HurtboxComponent

signal onStaminaChanged(newStamina : float, changeAmount : float)
signal onStaminaDepleted
signal guardBroken(attack : Attack)

var stamina : float
var regenDelay : float = 0.0

func atemptToSpendStamina(actionCost : float, forceSuceed : bool = false, staminaRegenDelay : float = 1.0) -> bool:
	if stamina - actionCost < 0.0:
		if forceSuceed:
			setStamina(0.0)
			regenDelay = staminaRegenDelay
			return true
		return false
	addStamina(-actionCost)
	regenDelay = staminaRegenDelay
	return true

func addStamina(amount : float) -> void:
	setStamina(stamina + amount)

func getStamina() -> float:
	return stamina

func setStamina(val : float) -> void:
	var prevVal = stamina
	stamina = clampf(val, -99999.9, maxStamina)
	if stamina < 0.0:
		onStaminaDepleted.emit()
	else:
		if prevVal != stamina:
			onStaminaChanged.emit(stamina, prevVal)


func onParry(a : Attack):
	addStamina(calcualteStaminaCostOffAttack(a) * -10.5)
	regenDelay = 1.0
	if stamina < 0.0:
		guardBroken.emit(a)
		#Tell Enemy that player is staggered

func onBlock(a : Attack):
	addStamina(calcualteStaminaCostOffAttack(a) * -20.0)
	regenDelay = 1.0
	if stamina < 0.0:
		guardBroken.emit(a)
		#Tell Enemy that player is staggered

func calcualteStaminaCostOffAttack(a : Attack) -> float:
	var staminaCost : float = a.attack_damage
	if a.attackType == 0: #Sharp
		staminaCost *= 0.5
	if a.attackType == 1: #Blunt
		staminaCost *= 2.0
	return staminaCost

func _process(delta: float) -> void:
	regenDelay -= delta
	if regenDelay <= 0.0:
		addStamina(staminaRegenPerSecound * delta)

func _ready() -> void:
	if !isPlayerHealth:
		set_health(MAX_HEALTH)
	stamina = maxStamina
	hurtboxComponent.parry.connect(onParry)
	hurtboxComponent.blocked.connect(onBlock)
