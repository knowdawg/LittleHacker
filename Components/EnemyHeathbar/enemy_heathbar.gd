extends Node
class_name EnemyHealthBar

@export var follow : Node2D

func _ready() -> void:
	$Sprite2D.visible = false
	EnemyHealthBarPositionManager.healthbars.append(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$Sprite2D.position = follow.global_position

func activate():
	$Sprite2D.visible = true
	$AnimationPlayer.play("Activate")

func deactivate():
	$AnimationPlayer.play("Deactivate")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Deactivate":
		$Sprite2D.visible = false
