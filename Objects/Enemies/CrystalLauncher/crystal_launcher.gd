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
	
	#if curRotation == 0.0:
		#%MovementComponent.gravity = 10.0
	#if curRotation == PI:
		#%MovementComponent.gravity = -10.0
	#if curRotation == PI / 2.0:
		#%MovementComponent.gravity = 0
		#%MovementComponent.g = Vector2.ZERO
	#if curRotation == 3.0 * PI / 2.0:
		#%MovementComponent.gravity = 0
		#%MovementComponent.g = Vector2.ZERO

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
