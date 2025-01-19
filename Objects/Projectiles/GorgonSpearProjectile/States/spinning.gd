extends State

@export var parent : CharacterBody2D
@export var collisionShape : CollisionShape2D
@export var movement : MovementComponent

var t = 0.0

func enter(_prevState):
	t = 0.0
	movement.applyForce(Vector2(0, -1), 500)
	movement.gravity = 2.0

func update_physics(_delta):
	var c : KinematicCollision2D = parent.move_and_collide(Vector2.ZERO)
	if c:
		parent.velocity = Vector2.ZERO
		trasitioned.emit(self, "Still")

func update(delta):
	t += delta * 0.5
	collisionShape.rotate(t)
