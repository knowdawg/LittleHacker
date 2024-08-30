extends Node2D

@onready var animator : AnimationPlayer = $SpriteAnimator

func hitFromLeft(_attack : Attack):
	animator.play("HitLeft")

func hitFromRight(_attack : Attack):
	animator.play("HitRight")
