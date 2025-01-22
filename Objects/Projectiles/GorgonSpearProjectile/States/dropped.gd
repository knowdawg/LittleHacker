extends State

@export var collisionShape : CollisionShape2D
@export var sprite : Sprite2D
@export var movement : MovementComponent
@export var attackComponent : AttackComponent
@export var hurtboxComponent : HurtboxComponent
@export var enemyHealthBar : EnemyHealthBar

var t = 0.0

func enter(_prevState):
	collisionShape.rotation = 0.0
	sprite.rotation = 0.0
	movement.gravity = 4.0
	var dir : Vector2 = (sprite.global_position - Game.player.global_position).normalized()
	movement.applyForce(dir, 50)
	attackComponent.disable()
	hurtboxComponent.disable()
	enemyHealthBar.delete(null)
	
