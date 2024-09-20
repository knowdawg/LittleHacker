extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * 2.0

	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		# Handle jump.
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		
		var inputDir := Input.get_vector("Left", "Right", "Up", "Down")
		var d = $TwitchPivot
		var direction = Vector3(inputDir.x, 0.0, inputDir.y).rotated(Vector3.UP, d.rotation.y)
		
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		else:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

var mouseSensitivity = 0.001
var twistInput = 0.0
var pitchInput = 0.0

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			twistInput = -event.relative.x * mouseSensitivity
			pitchInput = -event.relative.y * mouseSensitivity
			
			$TwitchPivot.rotate_y(twistInput)
			$TwitchPivot/PitchPivot.rotate_x(pitchInput)
			$TwitchPivot/PitchPivot.rotation.x = clamp($TwitchPivot/PitchPivot.rotation.x, -PI/2.0, PI/2)
			
			twistInput = 0.0
			pitchInput = 0.0
