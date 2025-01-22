extends Node2D

@export var damage : int = 1
@export var knockback : float = 0.0

var dirVector : Vector2 = Vector2.ZERO
var speed : float = 100.0

@onready var attackCom : AttackComponent = $RotationPivot/AttackComponent
@onready var rayCast : RayCast2D = $RotationPivot/RayCast
@onready var line : Line2D = $RotationPivot/Line2D

var t : float = 0.0
func _ready() -> void:
	t = 0.0
	$RotationPivot.rotation = dirVector.angle()
	
	attackCom.attack_damage = damage
	attackCom.knockback_force = knockback
	
	
	#rayCast.force_raycast_update()

func _physics_process(delta: float) -> void:
	if t == 0.0:
		rayCast.force_raycast_update()
		var c = rayCast.get_collision_point()
		attackCom.collisionShape.shape.length = (c - global_position).length()
		line.add_point(Vector2.ZERO)
		line.add_point(Vector2((c - global_position).length(), 0))
		$AnimationPlayer.play("Go")
	t += delta
	if t >= 0.1:
		attackCom.disable()
