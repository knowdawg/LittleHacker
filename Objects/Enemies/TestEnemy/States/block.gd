extends State

@export var onBlockEffects : Array[Node2D] = []

@export_group("States")
@export var nextState : State
@export var stateOnBlock : State
@export var stateOnGuardBreak : State

@export_group("Necesary Nodes")
@export var stateMachine : StateMachine
@export var parent : Node2D
@export var nodeToFlip : Node2D

@export var hurtboxComponent : HurtboxComponent

@export var animator : AnimationPlayer
@export var animationName : String
@export var animationLength : float

@export var blockWall : StaticBody2D


func enter(_prevState):
	animator.play(animationName)
	t = 0.0
	
	if nodeToFlip and parent:
		if parent.position.x > Game.player.global_position.x: 
			nodeToFlip.scale.x = 1.0
		else:
			nodeToFlip.scale.x = -1.0


var t : float = 0.0
func update(delta):
	t += delta
	
	if t > 0.4 and t < 1.7:
		blockWall.get_child(0).disabled = false;
		hurtboxComponent.setParry(true, 1)
	else:
		blockWall.get_child(0).disabled = true;
		hurtboxComponent.setParry(false)
	
	if t > animationLength:
		trasitioned.emit(self, nextState.name)


func exit(_nextState):
	blockWall.get_child(0).set_deferred("disabled", true);
	hurtboxComponent.setParry(false)


func onParry(attack):
	if stateMachine.current_state == self:
		
		for b in onBlockEffects:
			b.hitEfect(attack)
		
		trasitioned.emit(self, stateOnBlock.name)

func _ready():
	hurtboxComponent.parry.connect(onParry)
	blockWall.get_child(0).disabled = true;
