extends State
class_name GenericEnemyHackedState

@export var stateMachine : StateMachine
@export var parent : Node2D
@export var movement : MovementComponent
@export var nextState : State
@export var nextStateOnHack : State = nextState
@export var leftGrabPos : Marker2D
@export var rightGrabPos : Marker2D

@export_group("Animation")
@export var animationName : String
@export var animationPlayer : AnimationPlayer

@export_group("OptionalNodes")
@export var spriteDirectorComponent : SpriteDirectorComponent 

func _ready() -> void:
	Game.exitHackMode.connect(exitHackMode)

func exitHackMode():
	if isCurrentState:
		trasitioned.emit(self, nextStateOnHack.name)

var isCurrentState = false
func enter(_prevState):
	isCurrentState = true
	movement.resetForces()
	if animationPlayer:
		animationPlayer.play(animationName)

func update(_delta):
	if Game.player:
		var dir = Game.player.getSpriteDirection()
		var offset = Vector2(3, 0)
		if dir == -1:
			offset *= -1
			offset += leftGrabPos.position * Vector2(0, 1.0) + Vector2(6, 0)
		else:
			offset += rightGrabPos.position * Vector2(0, 1.0) + Vector2(-6, 0)
		
		
		var targetPos = Game.player.global_position + offset
		var pos = lerp(parent.global_position, targetPos, 0.5)
		
		Game.player.position = pos
	
	if Game.hackedEnemy != parent:
		trasitioned.emit(self, nextState.name)
		
	if spriteDirectorComponent:
		spriteDirectorComponent.lookAtPlayer()

func exit(_nextState):
	isCurrentState = false
