extends Node2D
class_name SmallPlayerHealthNode

@onready var full = $Full
@onready var filling = $Filling
@onready var animator = $AnimationPlayer

func showFull():
	if full.visible == false:
		animator.play("TurnOn")
	full.visible = true
	filling.visible = false

func showFilling(fillAmountNormal):
	if full.visible == true:
		animator.play("TurnOff")
	full.visible = false
	filling.visible = true
	
	filling.material.set_shader_parameter("waveHieght", 1.0 - fillAmountNormal)
