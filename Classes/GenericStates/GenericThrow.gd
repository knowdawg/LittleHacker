extends State
class_name GenericThrow

@export_group("Next States")
@export var agroState : State

@export_group("Necesary Nodes")
@export var animator : AnimationPlayer
@export var animationName : String
@export var animationLength : float
@export var projectileScene : PackedScene
@export var parent : CharacterBody2D

var target : Vector2 = Vector2.ZERO
var t : float = 0.0
func enter(_prevState):
	t = 0.0
	animator.play(animationName)

func update(delta):
	t += delta
	if t > animationLength:
		trasitioned.emit(self, agroState.name)

func throw():
	target = Game.player.global_position #placeholder for now, make more modular later
	var dirVector = (target - parent.global_position).normalized()
	var p = projectileScene.instantiate()
	p.dirVector = dirVector
	Game.level.add_child(p)
	p.position = parent.global_position
