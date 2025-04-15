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
	if parent.launchToPlayer:
		crystalSprite.rotation = parent.dirToPlayer - (PI / 2.0)
	else:
		crystalSprite.rotation = 0.0
	
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
			if parent.stickToGround():
				land()
		
		if %Left.is_colliding() and movement.force.x < 0.0:
			movement.force.x *= -1.0
		if %Right.is_colliding() and movement.force.x > 0.0:
			movement.force.x *= -1.0
		if %Up.is_colliding() and movement.force.y < 0.0:
			movement.force.y *= -1.0
		if %Down.is_colliding() and (movement.force.y + movement.g.y) > 0.0:
			movement.force.y *= -1.0
			movement.g.y *= -0.5
		
		if parent.curRotation != PI:
			if parent.stickToCeiling():
				%Sprite2D.position.y = -2.0
				land()


func land():
	spinning = false
	attackComponent.call_deferred("disable")
	animator.play("Land")
	movement.gravity = 0.0
	movement.g = Vector2.ZERO
	movement.resetForces()

var hasLaunched : bool = false
func launch():
	%Sprite2D.position.y = 0.0 #reset because of diplacement for ceiling landings
	if parent.curRotation == PI:
		%AfterImmageMarker.position.y = -2.0
	else:
		%AfterImmageMarker.position.y = -4.0
	
	attackComponent.enable()
	
	hasLaunched = true
	
	var f : float = 200.0
	if !parent.launchToPlayer:
		f = 300.0
	
	movement.resetForces()
	movement.applyForce(Vector2.from_angle(crystalSprite.rotation - (PI / 2.0)), f)
	movement.gravity = 3.0
	
	animator.play("Spin")
	spinning = true
	

func exit(_newState):
	attackComponent.call_deferred("disable")

func _on_animator_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Land" and stateMachine.current_state is CrystalLauncherLaunch:
		trasitioned.emit(self, "Agro")


func _on_attack_component_got_parried(attack : Attack) -> void:
	if stateMachine.current_state is CrystalLauncherLaunch:
		parent.global_position = attack.attack_position
		movement.resetForces()
		movement.g = Vector2.ZERO
		movement.applyForce(Vector2(0.0, -1.0), 100.0)
		spinTimer += spinDuration
