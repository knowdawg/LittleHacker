extends Node

var currentEnemies : Array[Enemy] = []
var canBeGrabbed : Array[Enemy] = []

func _ready() -> void:
	Game.onLevelSwitch.connect(levelSwitch)

func levelSwitch(_d):
	currentEnemies.clear()
	canBeGrabbed.clear()

func addEnemy(e : Enemy):
	currentEnemies.append(e)
	e.death.connect(removeEnemy)
	if e.canBeGrappled:
		canBeGrabbed.append(e)

func removeEnemy(e : Enemy):
	currentEnemies.remove_at(currentEnemies.find(e))
	if e.canBeGrappled:
		canBeGrabbed.remove_at(canBeGrabbed.find(e))


func findLockonTarget(startingPos : Vector2, ang : float, maxAngDis : float, maxDistance : float, lineOfSight : bool = true, mustBeOnScreen : bool = false) -> Enemy:
	var target : Enemy
	
	for e in canBeGrabbed:
		var ePos = e.global_position
		var eAngle = (startingPos - ePos).angle()
		var angleDif = abs(angle_difference(ang, eAngle))
		var dist = abs(startingPos.distance_to(ePos))
		
		#check if enemy is valid
		if angleDif > maxAngDis:
			continue
		if dist > maxDistance:
			continue
		if mustBeOnScreen:
			if abs(ePos.x - startingPos.x) > 52:
				continue
			if abs(ePos.y - startingPos.y) > 30:
				continue
		
		#if fist valid target
		if !target:
			target = e
			continue
		
		#swap if an enemy is found with a better angle
		var targetAngleDif = abs(startingPos.angle_to(target.global_position) - ang)
		if targetAngleDif < angleDif:
			target = e
	
	return target
