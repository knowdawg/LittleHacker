extends State

@export var animator : AnimationPlayer
@export var sprite : Sprite2D

func enter(_p):
	animator.play("Land")
	
	if randf() > 0.5:
		sprite.flip_h = true
