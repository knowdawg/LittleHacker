extends Node

@export var trackNode : Node2D
@export var spriteOffset := Vector2(11, 8)

@export var leftLegMaxDistatance : float = 10.0
@export var leftLegStartPos := Vector2(40, 50)
var leftLegNextTarget : Vector2

func _ready() -> void:
	%LeftLegTarget.position = leftLegStartPos

func _process(delta: float) -> void:
	%Sprite2D.position = trackNode.global_position + spriteOffset
	
	
	%NextLeftLegTarget.position.x = leftLegStartPos.x
	%NextLeftLegTarget.position.x -= (int(trackNode.global_position.x) % int(leftLegMaxDistatance)) + 10.0
	
	var lerpVal : float = lerp(%LeftLegTarget.position.x, %NextLeftLegTarget.position.x, 10.0 * delta)
	%LeftLegTarget.position.x = lerpVal

func quantize(val : float, amount : float) -> float:
	return round(val * amount) / amount
