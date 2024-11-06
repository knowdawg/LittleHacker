extends State

@export var stateMachine : StateMachine
@export var parent : Node2D
@export var movement : MovementComponent
@export var nextState : State
@export var leftGrabPos : Marker2D
@export var rightGrabPos : Marker2D

@export_group("Animation")
@export var animationName : String
@export var animationPlayer : AnimationPlayer

func _ready() -> void:
	Game.exitHackMode.connect(exitHackMode)

func exitHackMode():
	if isCurrentState:
		trasitioned.emit(self, nextState.name)

func _process(_delta: float) -> void:
	if Game.inHackMode and stateMachine.current_state != self:
		if Game.hackedEnemy == parent: #make sure that your the enemy that is being hacked!
			stateMachine.switchStates(self.name)

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
			offset.x += leftGrabPos.position.x
		else:
			offset.x += rightGrabPos.position.x
		
		var targetPos = Game.player.global_position + offset
		var pos = lerp(parent.global_position, targetPos, 0.5)
		
		movement.setPosition(pos)
	
	if Game.hackedEnemy != parent:
		trasitioned.emit(self, nextState.name)


func exit(_nextState):
	isCurrentState = false
