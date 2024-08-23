extends CharacterBody2D
class_name Player

@export var sprite : Sprite2D
@export var weaponSprite : Sprite2D

const SPEED = 70.0
const JUMP_VELOCITY = -130.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var v : Vector2 = Vector2.ZERO #substitute for velocity so that the charectar will freze if canMove / canFall is false
var dashV : Vector2 = Vector2.ZERO
var coyoteTime : float = 0.0

var curX = 0.0
var prevX = 0.0
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
		if direction:
			v.x = move_toward(v.x, direction * SPEED, 20.0 * delta * 60);
			if is_on_floor():
				pass
				#velocity += get_floor_normal() * v
		else:
			v.x = move_toward(v.x, 0.0, 20.0 * delta * 60);
		velocity.x += v.x
	
	if dashV.x != 0.0:
		velocity += dashV
		
	if velocity.x > 5:
		sprite.flip_h = true
	if velocity.x < -5:
		sprite.flip_h = false
		
	
	#curX = global_position.x
	#print(curX - prevX)
	#prevX = curX
	
	move_and_slide()

func _physics_process(delta):
	coyoteTime -= delta
	if is_on_floor():
		coyoteTime = 0.1

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
