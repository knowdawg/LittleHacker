extends HealthComponent
class_name StaminaComponent

@export var maxStamina : float
@export var staminaRegenPerSecound : float

signal onStaminaChanged(newStamina : float, changeAmount : float)
signal onStaminaDepleted

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

func _process(delta: float) -> void:
	regenDelay -= delta
	if regenDelay <= 0.0:
		addStamina(staminaRegenPerSecound * delta)

func _ready() -> void:
	if !isPlayerHealth:
		set_health(MAX_HEALTH)
	stamina = maxStamina
