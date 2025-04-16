extends Enemy

@export var hasSpear : bool = true
@export var spearProjectileScene : PackedScene
@onready var sprite : Sprite2D = $GorgonSprite

func customReady() -> void:
	$StateMachine.onHacked.connect(onHacked)

func _process(_delta: float) -> void:
	if velocity.x > 0:
		pass

var spearDropStates : Array[String] = ["IdleSpear", "ChaseSpear", "ThrowSpear", "ThrustSpear", "StunSpear", "PrepSpearThrow"]
func onHacked():
	for s in spearDropStates:
		if $StateMachine.current_state.name == s:
			var p = spearProjectileScene.instantiate()
			Game.littleLevel.call_deferred("add_child", p)
			p.position = global_position + Vector2(0, 4)
			p.drop()
