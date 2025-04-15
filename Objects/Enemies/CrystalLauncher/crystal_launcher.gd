extends CharacterBody2D
class_name CrystalLauncher


var curRotation : float = 0.0
var dirToPlayer : float = 0.0

var launchToPlayer : bool = true

func _ready() -> void:
	$AfterImageComponent.setActive(false)

func _process(_delta: float) -> void:
	if Game.doesPlayerExist():
		dirToPlayer = (global_position - (Game.player.global_position - Vector2(0.0, 3.0))).angle()
	%Sprite2D.rotation = curRotation

func _physics_process(_delta: float) -> void:
	move_and_slide()

func stickToGround() -> bool:
	if %Down.is_colliding():
		curRotation = 0.0
		global_position.y += 1
		return true
	return false

func stickToCeiling() -> bool:
	if %Up.is_colliding():
		curRotation = PI
		global_position.y -= 1
		return true
	return false


func _on_health_component_death(_attack: Attack) -> void:
	$AfterImageComponent.setActive(false)
	curRotation = 0.0
	%Sprite2D.rotation = 0.0
	%Sprite2D.position = Vector2.ZERO
