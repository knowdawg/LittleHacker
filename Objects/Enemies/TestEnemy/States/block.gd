extends State

@export var onBlockStartedEffects : Array[Node2D] = []
@export var onBlockEffects : Array[Node2D] = []

@export_group("States")
@export var nextState : State
@export var stateOnBlock : State
@export var stateOnGuardBreak : State

@export_group("Necesary Nodes")
@export var stateMachine : StateMachine
@export var parent : Node2D
@export var nodeToFlip : Node2D

@export var healthComponent : HealthComponent
@export var hurtboxComponent : HurtboxComponent

@export var animator : AnimationPlayer
@export var animationName : String
@export var animationLength : float

@export var blockWall : StaticBody2D
@export var blockEffect : Line2D

func enter(_prevState):
	animator.play(animationName)
	t = 0.0
	
	if nodeToFlip and parent:
		if parent.position.x > Game.player.global_position.x: 
			nodeToFlip.scale.x = 1.0
		else:
			nodeToFlip.scale.x = -1.0
	
func blockStartedEffecs():
	for b in onBlockStartedEffects:
		if b is GPUParticles2D:
			b.restart()
			b.emitting = true

var t : float = 0.0
func update(delta):
	t += delta
	
	if t > 0.4 and t < 1.7:
		blockWall.get_child(0).disabled = false;
		hurtboxComponent.setParry(true, 1)
		blockEffect.show()
	else:
		blockWall.get_child(0).disabled = true;
		hurtboxComponent.setParry(false)
		blockEffect.hide()
	
	if t > animationLength:
		trasitioned.emit(self, nextState.name)


func exit(_nextState):
	blockWall.get_child(0).set_deferred("disabled", true);
	hurtboxComponent.setParry(false)
	blockEffect.hide()


func onParry(attack):
	if stateMachine.current_state == self:
		
		for b in onBlockEffects:
			b.hitEfect(attack)
		
		trasitioned.emit(self, stateOnBlock.name)

func onBlockBroken(_attack):
	if stateMachine.current_state == self:
		if t > 0.4 and t < 1.7:
			trasitioned.emit(self, stateOnGuardBreak.name)

func _ready():
	healthComponent.hit.connect(onBlockBroken)
	hurtboxComponent.parry.connect(onParry)
	blockWall.get_child(0).disabled = true;
