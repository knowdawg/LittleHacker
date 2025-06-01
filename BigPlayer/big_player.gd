extends CharacterBody2D
class_name BigPlayer

var GRAVITY = 1000.0
var JUMP_VELOCITY := -200.0
var MOVE_SPEED := 4000.0

func _physics_process(delta: float) -> void:
	move_and_slide()


func check_for_movement(delta : float):
	if Input.is_action_pressed("Left"):
		velocity.x = delta * MOVE_SPEED * -1.0
	elif Input.is_action_pressed("Right"):
		velocity.x = delta * MOVE_SPEED * 1.0
	else:
		velocity.x = 0.0
	

func jump():
	velocity.y = JUMP_VELOCITY

func fall(delta):
	if !is_on_floor():
		velocity.y += delta * GRAVITY
	if is_on_floor():
		if velocity.y > 0:
			velocity.y = 0


func _process(_delta: float) -> void:
	%SpriteDirectorComponent.updateDirection()
	Game.bigPlayer = self

func enterLittleGameMode():
	modulate.a = 0.0

func leaveLittleGameMode():
	modulate.a = 1.0
