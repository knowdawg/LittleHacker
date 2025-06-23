extends Area2D
class_name ProximityAreaComponent

@export var requireLineOfSight : bool = true
@export var LOSOffset : Vector2 = Vector2.ZERO

signal onPlayerEnter
signal onPlayerExit

func _ready() -> void:
	%RayCast2D.position = LOSOffset

var a = null
func get_camera_bounds():
	var areas = get_overlapping_areas()
	if areas.size() > 1:
		return
	for area in areas:
		if area.get_parent() is CameraCoundriesComponent:
			if a != area.get_parent():
				a = area.get_parent()
			return area.get_parent()
	return null

@onready var ray : RayCast2D = $RayCast2D

var playerInside : bool = false
func is_player_inside():
	return playerInside

func checkForPlayerInside() -> bool:
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body is Player or body is BigPlayer:
			if requireLineOfSight:
				ray.rotation = (global_position - body.global_position).angle()
				#ray.force_raycast_update()
				var b = ray.get_collider()
				if b is Player or b is BigPlayer:
					return true
			else:
				return true
	return false

func _physics_process(_delta: float) -> void:
	playerInside = checkForPlayerInside()

func get_player():
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body is Player:
			return body
	return null


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		onPlayerEnter.emit()

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		onPlayerExit.emit()

func getAreas():
	return get_overlapping_areas()
