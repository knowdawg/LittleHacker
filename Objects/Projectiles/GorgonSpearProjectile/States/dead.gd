extends State

@export var sprite : Sprite2D
@export var hurtBox : HurtboxComponent
@export var healthbar : EnemyHealthBar


func enter(_prevState):
	sprite.hide()
	hurtBox.call_deferred("disable")
	healthbar.delete(null)
