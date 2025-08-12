extends CharacterBody2D
class_name Player

@export var sprite : Sprite2D
@export var weaponSprite : Sprite2D
@export var healthComponent : HealthComponent
@export var hurtboxComponent : HurtboxComponent
@export var stateMachine : PlayerStateMachine

@export var screenEffects : ScreenEffects

const SPEED = 70.0 * 0.45 * 1.0
const JUMP_VELOCITY = -145.0 * 0.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 500 * 0.5 #ProjectSettings.get_setting("physics/2d/default_gravity")

var v : Vector2 = Vector2.ZERO #substitute for velocity so that the charectar will freze if canMove / canFall is false
var knockbackVector : Vector2 = Vector2.ZERO
var slideVector : Vector2 = Vector2.ZERO
var boostVector : Vector2 = Vector2.ZERO #used for all forms of outside boost
var grappleBoost : Vector2 = Vector2.ZERO
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
		if is_on_ceiling() and v.y < 0:
			v.y = 0
			v.y += gravity * delta
			
		velocity.y += v.y
		
	
	if canMove:
		var direction = Input.get_axis("Left", "Right")
		if !Game.inLittleGame:	direction = Vector2.ZERO
		
		if direction:
			v.x = move_toward(v.x, direction * SPEED, 20.0 * delta * 60);
		else:
			v.x = move_toward(v.x, 0.0, 20.0 * delta * 60);
		
		if Input.is_action_pressed("Down") and Input.is_action_pressed("Jump") and Game.inLittleGame:
			set_collision_mask_value(2, false)
		else:
			set_collision_mask_value(2, true)
	
	velocity.x += v.x
	
	#Knockback
	if is_on_floor():
		knockbackVector.y = 0.0
	velocity.y += knockbackVector.y
	knockbackVector.y = move_toward(knockbackVector.y, 0, 10.0 * delta * 60)
	
	#Slide
	velocity += slideVector
	
	#boost
	velocity += boostVector
	boostVector.x = move_toward(boostVector.x, 0, delta * 100.0)
	boostVector.y = move_toward(boostVector.y, 0, delta * 200.0)
	
	velocity += grappleBoost
	grappleBoost.x = move_toward(grappleBoost.x, 0, delta * 500.0)
	grappleBoost.y = move_toward(grappleBoost.y, 0, delta * 50.0)
	
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
	$HackTargetDetectionBox.scale.x = -getSpriteDirection()
	coyoteTime -= delta
	if is_on_floor() or $StateMachine.current_state is PlayerWallCling:
		coyoteTime = 0.15

var lerpT : float = 0.0
func _process(delta: float) -> void:
	%FPS.text = str(Engine.time_scale  * 1.0 / delta).pad_decimals(2)
	
	Game.player = self
	
	if %HurtboxComponent.parrying:
		%HurtboxComponent.scale = Vector2(4.0, 2.0)
	else:
		%HurtboxComponent.scale = Vector2(1.0, 1.0)
	
	var c : Camera2D = Game.camera
	var camPos = c.global_position
	var snapDis = (camPos - floor(camPos) - Vector2(0.0, 1.0)) / Vector2(128, 72)
	RenderingServer.global_shader_parameter_set("CameraSnapDistance", snapDis)
	
	var p : CameraCoundriesComponent = $CameraBounds.get_camera_bounds()
	if p:
		var targetPos = p.closest_rectangle_position(global_position)
		%PlayerCamera.global_position = targetPos
		#lerpT -= delta
		#if lerpT == -delta: #Lock onto player when spawn in
			#%PlayerCamera.global_position = targetPos
			#return
		#if targetPos.distance_to(%PlayerCamera.global_position) > 5.0:
			#lerpT = 0.4
			#%PlayerCamera.global_position = lerp(%PlayerCamera.global_position, targetPos, delta * 10.0)
		#elif lerpT > 0.0:
			#%PlayerCamera.global_position = lerp(%PlayerCamera.global_position, targetPos, delta * 10.0)
		#elif lerpT <= 0.0:
			#%PlayerCamera.global_position = targetPos#lerp(%PlayerCamera.global_position, targetPos, delta * 10.0)
		#
		
		

func _ready():
	$HealthComponent.grabbed.connect(grabbed)
	Game.enterHackMode.connect(enterHackMode)
	var t : Tween = create_tween()
	t.tween_property(%PointLight2D, "texture_scale", 1.0, 0.3)
	

func canCoyoteJump():
	return coyoteTime > 0.0

func facingRight():
	return sprite.flip_h

func jump():
	v.y = JUMP_VELOCITY

func killJump():
	v.y /= 2.0;

var parrying = false
func setParry(isParry : bool):
	parrying = isParry

func _on_attack_down_area_entered(_area: Area2D) -> void:
	jump()

func hitFromLeft(_attack : Attack):
	knockbackVector.x = 100.0
	v.x = 0.0
	if !stateMachine.current_state is PlayerGrabbed:
		$StateMachine.onChildTransition($StateMachine.current_state, "Stun")
	hitEffects()

func hitFromRight(_attack : Attack):
	knockbackVector.x = -100.0
	v.x = 0.0
	if !stateMachine.current_state is PlayerGrabbed:
		$StateMachine.onChildTransition($StateMachine.current_state, "Stun")
	hitEffects()

func hitEffects():
	$Sounds/PlayerHitMain.play()
	$Sounds/PlayerHitSecoundary.play()
	$MotionBlur.glitch()
	Game.camera.set_shake(10.0)

var parryStunTime = 0.3
var parriedAttack : Attack
func parry(attack : Attack):
	parriedAttack = attack
	Game.camera.set_shake(2.0)
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

func grabbed(attack : Attack):
	hurtboxComponent.call_deferred("disable")
	attack.grabComponent.setActive(true, self)
	stateMachine.switchStates("Grabbed")

func releaseGrab():
	hurtboxComponent.call_deferred("enable")
	rotation = 0
	stateMachine.switchStates("Idle")

func dealDirectDamage(attack : Attack):
	$ScaleAnimator.play("Stun")
	healthComponent.damage(attack)

func heal(amount : float):
	healthComponent.heal(amount)

func initialize(data : SceneSwitchData):
	var playerData = data.playerData
	if playerData:
		healthComponent.set_health(playerData.health)
	else:
		healthComponent.set_health(healthComponent.MAX_HEALTH)
	sprite.flip_h = !data.faceRight
	

signal forceExitZipline
func ziplineActivated():
	v = Vector2.ZERO
	stateMachine.switchStates("Zipline")

func exitZipline():
	forceExitZipline.emit()

func _on_health_component_death(_attack: Attack) -> void:
	screenEffects.showStatic()
	healthComponent.locked = true
	%RespawnTimer.start()
	Game.player = null


func _on_respawn_timer_timeout() -> void:
	Game.respawnPlayer()


func _on_health_component_hazard(_attack: Attack) -> void:
	knockbackVector = Vector2.ZERO
	
	global_position = Game.platformingRespawnPos
