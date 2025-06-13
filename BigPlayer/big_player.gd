extends CharacterBody2D
class_name BigPlayer

var GRAVITY = 800.0
var JUMP_VELOCITY := -250.0
var MOVE_SPEED := 2500.0
var RUN_SPEED := 6000.0


var xMovement := Vector2.ZERO
var runMovement := Vector2.ZERO
var shimmyMoment := Vector2.ZERO
var jumpFallVector := Vector2.ZERO
var jumpBoostVector := Vector2.ZERO
var attackBoost := Vector2.ZERO

var knockback := Vector2.ZERO


func _physics_process(delta: float) -> void:
	if Game.inLittleGame:
		return
	
	velocity += xMovement
	velocity += jumpFallVector
	velocity += jumpBoostVector
	velocity += runMovement
	velocity += attackBoost
	velocity += knockback
	velocity += shimmyMoment
	
	move_and_slide()
	velocity = Vector2.ZERO
	
	xMovement = Vector2.ZERO#xMovement.move_toward(Vector2.ZERO, delta * 180.0)
	jumpBoostVector = jumpBoostVector.move_toward(Vector2.ZERO, delta * 240.0)
	runMovement = Vector2.ZERO#runMovement.move_toward(Vector2.ZERO, delta * 360.0)
	attackBoost = Vector2.ZERO
	knockback = knockback.move_toward(Vector2.ZERO, delta * 480.0)
	shimmyMoment = Vector2.ZERO

func check_for_movement(delta : float):
	if Input.is_action_pressed("Left"):
		xMovement.x = delta * MOVE_SPEED * -1.0
	elif Input.is_action_pressed("Right"):
		xMovement.x = delta * MOVE_SPEED * 1.0

func check_for_movement_run(delta : float):
	if Input.is_action_pressed("Left"):
		runMovement.x = delta * RUN_SPEED * -1.0
	elif Input.is_action_pressed("Right"):
		runMovement.x = delta * RUN_SPEED * 1.0

func jump(horizantalBoost : float = 0.3, jumpHight : float = 1.0):
	jumpFallVector.y = JUMP_VELOCITY * jumpHight
	if Input.is_action_pressed("Left"):
		jumpBoostVector.x = JUMP_VELOCITY * horizantalBoost
	elif Input.is_action_pressed("Right"):
		jumpBoostVector.x = JUMP_VELOCITY * -horizantalBoost

func fall(delta):
	if !is_on_floor():
		jumpFallVector.y += delta * GRAVITY
	if is_on_floor():
		if jumpFallVector.y > 0:
			jumpFallVector.y = 0
	if is_on_ceiling():
		if jumpFallVector.y < 0:
			jumpFallVector.y = 0

func getSummedVelocities() -> Vector2:
	var sum := Vector2.ZERO
	sum += jumpFallVector
	sum += xMovement
	sum += runMovement
	sum += jumpBoostVector
	sum += shimmyMoment
	
	return sum

func _process(_delta: float) -> void:
	Game.bigPlayer = self
	
	%StaminaComponent.maxStamina = %StaminaComponent.MAX_HEALTH

func enterLittleGameMode():
	modulate.a = 0.0

func leaveLittleGameMode():
	modulate.a = 1.0

func getDirection() -> float:
	if %PlayerSprite.flip_h:
		return 1.0
	else:
		return -1.0

func updateSpriteDirection():
	%SpriteDirectorComponent.updateDirection()

func takeKnockback(a : Attack, knockBackMultiplier : float = 1.0):
	var kbVec := Vector2(70.0, 0.0)
	if global_position < a.attack_position:
		kbVec.x *= -1.0
	knockback += kbVec * knockBackMultiplier

func _on_hurtbox_component_blocked(a: Attack) -> void:
	takeKnockback(a)
	if %StaminaComponent.stamina >= 0.0: #If gaurd isnt Broken
		%ScreenEffects.block()

func _on_hurtbox_component_parry(a: Attack) -> void:
	takeKnockback(a)

func _on_stamina_component_hit(a: Attack) -> void:
	takeKnockback(a, 2.0)
	Game.setTimeScale(0.1)
	if a.attackType == Attack.SHARPNESS.SHARP:
		%ScreenEffects.sharpHit()
	if a.attackType == Attack.SHARPNESS.BLUNT:
		%ScreenEffects.bluntHit()

func _on_stamina_component_guard_broken(a: Attack) -> void:
	%ScreenEffects.guardBreak()
