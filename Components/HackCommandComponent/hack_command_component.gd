extends Line2D
class_name HackCommandComponent

@export var cost = 0.0
@export var hackName = ""
@export var healthComponent : HealthComponent


signal executed

var enabled : bool = true

func isExecutable():
	return (healthComponent.get_weakness() >= cost and enabled)

func execute():
	executed.emit()
	healthComponent.set_weakness(healthComponent.get_weakness() - cost)
	executeHack()

#Used for manualy setting if a hack can be used
func disable():
	enabled = false

func enable():
	enabled = true

func executeHack():
	pass
