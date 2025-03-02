extends GenericAttackState
class_name GenericProjectileAttack

@export_group("Projectile Data")
@export var projectileScene : PackedScene
@export var projectileDirectionNode : Node2D
@export var reverseDirection : bool = true
@export var distanceAwayFromParent : float = 0.0
@export var offset : Vector2 = Vector2.ZERO

func projectile():
	var dirVector = Vector2(1.0, 0.0)
	dirVector *= projectileDirectionNode.scale
	dirVector.x *= (-1.0 if reverseDirection else 1.0)
	
	var p : Projectile = projectileScene.instantiate()
	p.dirVector = dirVector
	p.flipH = false if projectileDirectionNode.scale == Vector2(1.0, 1.0) else true
	#replace with a Game function
	Game.addProjectile(p)
	p.position = parent.global_position + (dirVector * distanceAwayFromParent) + offset
