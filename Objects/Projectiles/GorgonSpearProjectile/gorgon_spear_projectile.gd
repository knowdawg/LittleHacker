extends CharacterBody2D

var dirVector : Vector2 = Vector2.ZERO
var speed : float = 150.0
var t = 1.0

func drop() -> void:
	$StateMachine.call_deferred("switchStates", "Dropped")
	

func _process(_delta: float) -> void:
	if Game.player:
		if Game.player.global_position > global_position:
			$StateMachine/Throw.projDir = Vector2(-1.0, 0.0)
		else:
			$StateMachine/Throw.projDir = Vector2(1.0, 0.0)
