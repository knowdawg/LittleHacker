extends State
class_name GenericThrow

@export var throwOnEnter : bool = false

@export_group("Next States")
@export var agroState : State

@export_group("Necesary Nodes")
@export var animator : AnimationPlayer
@export var animationName : String
@export var animationLength : float
@export var projectileScene : PackedScene
@export var parent : CharacterBody2D

@export_group("Direction")
@export var targetPlayer : bool =  true
@export var projDir : Vector2

@export_group("Optional Nodes")
@export var spriteDirector : SpriteDirectorComponent


var target : Vector2 = Vector2.ZERO
var t : float = 0.0
func enter(_prevState):
	t = 0.0
	animator.play(animationName)
	if throwOnEnter:
		throw()
	if spriteDirector:
		spriteDirector.lookAtPlayer()

func update(delta):
	t += delta
	if t > animationLength:
		trasitioned.emit(self, agroState.name)

func throw():
	var dirVector
	if targetPlayer:
		target = Game.player.global_position + Vector2(0, -2)
		dirVector = (target - parent.global_position).normalized()
	else:
		dirVector = projDir
	var p = projectileScene.instantiate()
	p.dirVector = dirVector
	Game.level.add_child(p)
	p.position = parent.global_position
