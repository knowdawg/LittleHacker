extends CharacterBody2D

enum attackOptions {BLUNT, SHARP, NIETHER = -1}
@export var attackSetting : attackOptions = -1

func _ready() -> void:
	if attackSetting == attackOptions.SHARP:
		%AnimationPlayer.play("Sharp")
	if attackSetting == attackOptions.BLUNT:
		%AnimationPlayer.play("Blunt")
