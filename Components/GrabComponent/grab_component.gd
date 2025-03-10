extends Node
class_name GrabComponent

@export var nodeToFollow : Node2D

var isActive = false
var objectToControll : Node2D

func setActive(active : bool, object = null):
	if active == false:
		if is_instance_valid(objectToControll):
			if objectToControll.has_method("releaseGrab"):
				objectToControll.releaseGrab()
	isActive = active
	objectToControll = object

func _process(_delta: float) -> void:
	if isActive and is_instance_valid(objectToControll):
		$Marker2D.global_position = nodeToFollow.global_position
		$Marker2D.rotation = nodeToFollow.rotation
		objectToControll.rotation = $Marker2D.rotation
		objectToControll.global_position = $Marker2D.global_position

func dealDamageToObject(dmg : int):
	var a = Attack.new()
	a.attack_damage = dmg
	if is_instance_valid(objectToControll):
		if objectToControll.has_method("dealDirectDamage"):
			objectToControll.dealDirectDamage(a)
