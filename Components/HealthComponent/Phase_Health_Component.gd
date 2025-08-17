extends HealthComponent

signal onLockHit(lockName : String)
@export var lockPoints : Dictionary[float, String]
@onready var lowestHealth : float = MAX_HEALTH #ensure that the same locks arent hit multiple times due to healing


func set_health(val : float):
	var highestLockVal : float #Ensure that the highest posible lock is selected
	for l in lockPoints:
		if l < lowestHealth and val <= l:
			if !highestLockVal:
				highestLockVal = l
			else:
				if l > highestLockVal:
					highestLockVal = l
	if highestLockVal:
		lowestHealth = highestLockVal
		health = highestLockVal
		onLockHit.emit(lockPoints[highestLockVal])
		return
	
	if val < lowestHealth:
		lowestHealth = val
	
	
	if val > MAX_HEALTH:
		health = MAX_HEALTH
	else:
		health = val
