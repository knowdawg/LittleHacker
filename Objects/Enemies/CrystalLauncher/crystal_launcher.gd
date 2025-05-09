extends Enemy
class_name CrystalLauncher

@export var sleeping : bool = false

var curRotation : float = 0.0
var dirToPlayer : float = 0.0

var launchToPlayer : bool = true

func wake():
	%StateMachine.switchStates("Wake")

func customReady() -> void:
	$AfterImageComponent.setActive(false)
	
	if sleeping:
		%StateMachine.switchStates("Sleep")

func _process(_delta: float) -> void:
	if Game.doesPlayerExist():
		dirToPlayer = (global_position - (Game.player.global_position - Vector2(0.0, 3.0))).angle()
	%Sprite2D.rotation = curRotation
	%EliteSlamProjectile.rotation = %Sprite2D.rotation
	%EliteSlamProjectile.position = %Sprite2D.position

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

func canBeGrappledTo() -> bool:
	if %StateMachine.current_state.name == "Sleep":
		return false
	return true
