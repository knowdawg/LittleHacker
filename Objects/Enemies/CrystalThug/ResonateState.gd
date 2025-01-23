extends GenericParriedState

@export var healthComponent : HealthComponent
@export var projectileScene : PackedScene
@export var parent : CharacterBody2D

func customEnter(_prevState):
	healthComponent.hit.connect(onHit)
	healthComponent.set_health(1)

func onHit(_attack):
	parent.call_deferred("resonate")

#func realOnHit():
	#var p = projectileScene.instantiate()
	#Game.level.add_child(p)
	#p.position = parent.global_position + Vector2(0, 7)
