extends Node

@export var follow : Node2D

func setXPos():
	for c in get_children():
		if c is Node2D:
			c.global_position.x = follow.global_position.x

func setYPos():
	for c in get_children():
		if c is Node2D:
			c.global_position.y = follow.global_position.y
	
func setPos():
	setXPos()
	setYPos()
