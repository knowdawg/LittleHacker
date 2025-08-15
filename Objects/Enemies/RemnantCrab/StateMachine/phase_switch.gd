extends GenericTransitionState

@export var velocityCurve : Curve
@export var velocity : float = 100.0
@export var parent : RemnantCrab
@export var stateMachine : RemnantCrabStateMachine
@export var skullSprite : Sprite2D

var v : float = 0.0
var switchedAnimation = false
var dir : float = 1.0
func customEnter(_prevState):
	switchedAnimation = false
	v = -velocity
	dir = Vector2(stateMachine.vectorToPlayer.x, 0.0).normalized().x


func customUpdate(delta):
	if t <= 3.0:
		parent.velocity.x = v
		v = -velocity * velocityCurve.sample(t) * dir
	if t >= 3.0 and switchedAnimation == false:
		switchedAnimation = true
		animator.play("PhaseTransition")
	if (t >= 3.5 and t <= 6.0) or (t >= 7.0 and t <= 8.7):
		parent.suckInPlayer(delta, 5.0)
	
	
