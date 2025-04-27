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
	if currentEnemies.has(e):
		currentEnemies.remove_at(currentEnemies.find(e))
	if e.canBeGrappled:
		if canBeGrabbed.has(e):
			canBeGrabbed.remove_at(canBeGrabbed.find(e))


func findGrappleTarget(startingPos : Vector2, ang : float, maxAngDis : float, maxDistance : float, lineOfSight : bool = true, mustBeOnScreen : bool = false) -> Enemy:
	var target : Enemy = null
	
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
		if !e.canBeGrappledTo():
			continue
		if lineOfSight:
			var space_state = e.get_world_2d().direct_space_state
			var query = PhysicsRayQueryParameters2D.create(startingPos, e.global_position, 1)
			var result = space_state.intersect_ray(query)
			
			if !result.is_empty():
				continue
		
		#if fist valid target
		if !target:
			target = e
			continue
		
		#swap if an enemy is found with a better angle
		#var targetAngleDif = abs(startingPos.angle_to(target.global_position) - ang)
		var targetDisDif = abs(startingPos.distance_to(target.global_position))
		
		#var tWieght = 1 / (targetAngleDif * targetDisDif)
		#var eWieght = 1 / (angleDif * dist)
		
		if dist < targetDisDif:#targetAngleDif < angleDif:#eWieght > tWieght:
			target = e
	
	return target
