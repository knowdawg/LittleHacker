extends CharacterBody2D
class_name Player

@export var sprite : Sprite2D
@export var weaponSprite : Sprite2D

const SPEED = 70.0 * 0.45
const JUMP_VELOCITY = -140.0 * 0.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 500 * 0.5 #ProjectSettings.get_setting("physics/2d/default_gravity")

var v : Vector2 = Vector2.ZERO #substitute for velocity so that the charectar will freze if canMove / canFall is false
var knockbackVector : Vector2 = Vector2.ZERO
var slideVector : Vector2 = Vector2.ZERO
var rollJumpBoost : Vector2 = Vector2.ZERO
var dashV : Vector2 = Vector2.ZERO
var coyoteTime : float = 0.0
func update_physics(delta, canFall : bool = true, canMove : bool = true):
	velocity = Vector2.ZERO
	
	if canFall:
		if !is_on_floor():
			v.y += gravity * delta
		elif is_on_floor() and v.y > 0:
			v.y = 0;
		if is_on_ceiling():
			v.y = 0
			v.y += gravity * delta
			
		velocity.y += v.y
		
	
	if canMove:
		var direction = Input.get_axis("Left", "Right")
		if Game.inTerminal:
			direction = 0
		if direction:
			v.x = move_toward(v.x, direction * SPEED, 20.0 * delta * 60);
		else:
			v.x = move_toward(v.x, 0.0, 20.0 * delta * 60);
	
	velocity.x += v.x
	
	#Knockback
	if is_on_floor():
		knockbackVector.y = 0.0
	velocity.y += knockbackVector.y
	knockbackVector.y = move_toward(knockbackVector.y, 0, 10.0 * delta * 60)
	
	#Slide
	velocity += slideVector
	
	#rollJumpBoost.x = clamp(rollJumpBoost.x, -SPEED - v.x, SPEED - v.x)
	velocity += rollJumpBoost
	rollJumpBoost.x = move_toward(rollJumpBoost.x, 0, delta * 100.0)
	
	#velocity.x += v.x
	velocity.x += knockbackVector.x
	knockbackVector.x = move_toward(knockbackVector.x, 0, 10.0 * delta * 60)
	
	
	if dashV.x != 0.0:
		velocity += dashV
	
	if canMove:
		if velocity.x > 5:
			sprite.flip_h = true
		if velocity.x < -5:
			sprite.flip_h = false
	
	move_and_slide()

func _physics_process(delta):
	coyoteTime -= delta
	if is_on_floor() or $StateMachine.current_state is PlayerWallCling:
		coyoteTime = 0.1

func _process(_delta: float) -> void:
	Game.player = self

func _ready():
	Game.enterHackMode.connect(enterHackMode)

func canCoyoteJump():
	return coyoteTime > 0.0

func facingRight():
	return sprite.flip_h

func jump():
	v.y = JUMP_VELOCITY

func killJump():
	v.y /= 2.0;

func canParry():
	return true

var parrying = false
func setParry(isParry : bool):
	parrying = isParry

func _on_attack_down_area_entered(_area: Area2D) -> void:
	jump()

func hitFromLeft(_attack : Attack):
	knockbackVector.x = 100.0
	v.x = 0.0
	$StateMachine.onChildTransition($StateMachine.current_state, "Stun")
	#Game.slowTime(0.3, 0.01)

func hitFromRight(_attack : Attack):
	knockbackVector.x = -100.0
	v.x = 0.0
	$StateMachine.onChildTransition($StateMachine.current_state, "Stun")
	#Game.slowTime(0.3, 0.01)

var parryStunTime = 0.3
var parriedAttack : Attack
func parry(attack : Attack):
	parriedAttack = attack
	
	var c = $StateMachine.current_state #dont enter if in a certain state
	if c is PlayerHackAttack or c is PlayerHackMode:
		return
		
	if is_on_floor():
		parryStunTime = 0.3 #modify based on attack knockback
		$StateMachine.onChildTransition($StateMachine.current_state, "ParryStun")

func getSpriteDirection()->float:
	var dir = 1.0
	if sprite.flip_h == false:
		dir = -1.0
	return dir

func enterHackMode():
	pass
