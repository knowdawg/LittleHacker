extends Enemy

@export var buggy : PackedScene
enum colorChoices {PURPLE = 0, RED = 1, GREEN = 2}
@export var color : colorChoices
@export var sleeping : bool = false #enable if the enemy is to be woken up in the furture

@export_group("Sprite Sheets")
@export var greenSprite : Resource
@export var redSprite : Resource
@export var greenSlam : Resource
@export var redSlam : Resource
@export var greenShater : Resource
@export var redShater : Resource
@export var projectile : PackedScene

func wake():
	%StateMachine.switchStates("Wake")

var canResonate : bool = true
# Called when the node enters the scene tree for the first time.
func customReady() -> void:
	if sleeping:
		%StateMachine.switchStates("Sleep")
	
	$GeneralComponents/HealthComponent.hit.connect(checkResonanceHit)
	if color == 0:
		pass
	elif color == 1:
		$Sprite2D.texture = redSprite
		$HeadShatter.texture = redShater
		$AttackComponents/HeadSlam/CrystalExsplotionEffect.texture = redSlam
		$PointLight2D.color = Color(0.15, 0, 0)
	elif color == 2:
		$Sprite2D.texture = greenSprite
		$HeadShatter.texture = greenShater
		$AttackComponents/HeadSlam/CrystalExsplotionEffect.texture = greenSlam
		$PointLight2D.color = Color(0, 0.15, 0)

func checkResonanceHit(attack : Attack):
	if attack.attackName == "CrystalResonanceBlast":
		if canResonate:
			$ResonanceTimer.start()
			canResonate = false
			$ResonanceCooldown.start()

func resonate():
	$Sounds/Resonate.play()
	var p = projectile.instantiate()
	p.color = color
	Game.addProjectile(p)
	p.position = global_position

func _process(_delta: float) -> void:
	if $StateMachine.current_state.name == "Resonate":
		if $Sounds/Resonating.playing == false:
			$Sounds/Resonating.play()
	else:
		$Sounds/Resonating.stop()
	
	#if Game.doesPlayerExist():
		#if Game.player.global_position.y > global_position.y:
			#set_collision_mask_value(2, false)
		#else:
			#set_collision_mask_value(2, true)

func _on_resonance_timer_timeout() -> void:
	resonate()

func _on_resonance_cooldown_timeout() -> void:
	canResonate = true

func _on_head_shatter_executed() -> void:
	for i in randi_range(1, 2):
		var b : HealthBuggy = buggy.instantiate()
		Game.addEnemy(b)
		b.position = global_position
		b.movement.applyForce(Vector2(randf_range(-0.3, 0.3), -1), 150)

func onPlayerStuckToMeWithGrapple():
	%SpriteDirectorComponent.lookAtPlayer()
	%StateMachine.switchStates("Grappled")

func onPlayerJumpOffMe():
	%StateMachine.switchStates("Stun")

func canBeGrappledTo() -> bool:
	if %StateMachine.current_state.name == "Sleep":
		return false
	else:
		return true
