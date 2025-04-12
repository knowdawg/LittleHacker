extends State
class_name CrystalLauncherLaunch

@export var spinDuration : float = 0.5

@export var stateMachine : StateMachine
@export var parent : CrystalLauncher
@export var animator : AnimationPlayer
@export var crystalSprite : Sprite2D
@export var movement : MovementComponent
@export var attackComponent : AttackComponent

var t = 0.0
var spinTimer : float = 0.0
var spinning = false
func enter(_prevState):
	crystalSprite.rotation = parent.dirToPlayer - (PI / 2.0)
	
	attackComponent.generateAttackID()
	
	animator.play("Launch")
	
	t = 0.0
	spinTimer = 0.0
	hasLaunched = false
	spinning = false

func update(delta):
	t += delta
	
	if t >= 1.0:
		if !hasLaunched:
			launch()
	
	if spinning:
		spinTimer += delta
		if spinTimer > spinDuration:
			if parent.stickToTerrarian():
				spinning = false
				attackComponent.call_deferred("disable")
				animator.play("Land")
				movement.gravity = 0.0
				movement.g = Vector2.ZERO
				movement.resetForces()
		
		if %Left.is_colliding() and movement.force.x < 0.0:
			movement.force.x *= -1.0
		if %Right.is_colliding() and movement.force.x > 0.0:
			movement.force.x *= -1.0
		if %Up.is_colliding() and movement.force.y < 0.0:
			movement.force.y *= -1.0
		if %Down.is_colliding() and (movement.force.y + movement.g.y) > 0.0:
			movement.force.y *= -1.0
			movement.g.y *= -0.5


var hasLaunched : bool = false
func launch():
	attackComponent.enable()
	
	hasLaunched = true
	
	movement.resetForces()
	movement.applyForce(Vector2.from_angle(crystalSprite.rotation - (PI / 2.0)), 150.0)
	movement.gravity = 3.0
	
	animator.play("Spin")
	spinning = true
	

func exit(_newState):
	attackComponent.call_deferred("disable")

func _on_animator_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Land" and stateMachine.current_state is CrystalLauncherLaunch:
		trasitioned.emit(self, "Agro")


func _on_attack_component_got_parried(_attack) -> void:
	if stateMachine.current_state is CrystalLauncherLaunch:
		movement.resetForces()
		movement.applyForce(Vector2(0.0, -1.0), 100.0)
		spinTimer += spinDuration
