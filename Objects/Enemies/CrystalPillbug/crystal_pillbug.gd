extends CharacterBody2D

@export var facingLeft = true

func _ready() -> void:
	if !facingLeft:
		%ProximityArea.scale = Vector2(-1.0, 1.0)
		%SpriteDirectorComponent.flipXDir()


func _on_state_machine_state_switched(_prevState: State, newState: State) -> void:
	if newState.name.to_lower() == "death":
		%BlockerShape.set_deferred("disabled", true)
