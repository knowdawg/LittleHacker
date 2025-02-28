extends Node2D

@export var prox : ProximityAreaComponent
var areas : Array[Area2D]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	areas = prox.getAreas()
	areas.sort_custom(sortByDistance)
	
	if areas.size() > 0:
		areas[0].showText()
		
		if Input.is_action_just_pressed("Interact"):
			areas[0].interact()

func sortByDistance(a1, a2):
	var dis1 : float = (a1.global_position - global_position).length()
	var dis2 : float = (a2.global_position - global_position).length()
	if dis1 < dis2:
		return true
	return false
