extends State
class_name GorgonSpearSpinningState

@export var parent : CharacterBody2D
@export var collisionShape : CollisionShape2D
@export var sprite : Sprite2D
@export var movement : MovementComponent
@export var animator : AnimationPlayer
@export var raycast : RayCast2D

var t = 0.0

func enter(_prevState):
	collisionShape.rotation = PI/2.0
	sprite.rotation = 0.0
	t = 0.0
	movement.applyForce(Vector2(0, -1), 200)
	movement.gravity = 4.0
	animator.play("Spin")

func update(delta):
	t += delta
	if raycast.is_colliding() and t > 0.3:
		trasitioned.emit(self, "Still")
