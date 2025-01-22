extends State

@export var parriedState : State
@export var animator : AnimationPlayer
@export var healthbar : EnemyHealthBar

@export var sprite : Sprite2D
@export var hurtbox : HurtboxComponent

var t : float = 99999.9
func enter(prevState):
	if prevState is GorgonSpearMovingState:
		animator.play("Destroy")
		t = 0.0
		return
	animator.play("Land")

func getParryState():
	return parriedState

func update(delta):
	t -= delta
	if t < -0.5:
		healthbar.delete(null)

func exit(nextState):
	if nextState is GorgonSpearSpinningState:
		sprite.self_modulate = Color(1.0, 1.0, 1.0, 1.0)
		hurtbox.enable()
		t = 99999.9
