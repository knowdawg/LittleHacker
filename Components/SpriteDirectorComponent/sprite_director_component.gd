extends Node
class_name SpriteDirectorComponent

@export var spriteToFlip : Sprite2D
@export var velocityToCheck : CharacterBody2D

@export var flipX : bool = true
@export var flipY : bool = false

@export var useVelocityVariable : bool = false

var oldPos : Vector2 = Vector2.ZERO
var deltaPos : Vector2 = Vector2.ZERO
func _process(_delta: float) -> void:
	deltaPos = velocityToCheck.global_position - oldPos
	oldPos = velocityToCheck.global_position
	
	
func updateDirection():
	if flipX:
		if deltaPos.x > 0:
			spriteToFlip.flip_h = true
		elif deltaPos.x < 0:
			spriteToFlip.flip_h = false
		if useVelocityVariable:
			if velocityToCheck.getSummedVelocities().x > 0:
				spriteToFlip.flip_h = true
			elif velocityToCheck.getSummedVelocities().x < 0:
				spriteToFlip.flip_h = false
	

func lookAtPlayer():
	if Game.doesPlayerExist():
		if velocityToCheck.global_position.x > Game.player.global_position.x:
			spriteToFlip.flip_h = false
		else:
			spriteToFlip.flip_h = true

func lookAwayFromPlayer():
	if Game.doesPlayerExist():
		if velocityToCheck.global_position.x > Game.player.global_position.x:
			spriteToFlip.flip_h = true
		else:
			spriteToFlip.flip_h = false

func flipXDir():
	if flipX:
		spriteToFlip.flip_h = !spriteToFlip.flip_h
