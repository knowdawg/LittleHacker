extends Enemy

@export var projectile : PackedScene
@export var buggy : PackedScene

var canResonate : bool = true
# Called when the node enters the scene tree for the first time.
func customReady() -> void:
	$GeneralComponents/HealthComponent.hit.connect(checkResonanceHit)

func checkResonanceHit(attack : Attack):
	if attack.attackName == "CrystalResonanceBlast":
		if canResonate:
			$ResonanceTimer.start()
			canResonate = false
			$ResonanceCooldownTimer.start()

func resonate():
	$Sounds/Resonate.play()
	var p = projectile.instantiate()
	#p.color = color
	Game.addProjectile(p)
	p.position = global_position

func _process(_delta: float) -> void:
	if $StateMachine.current_state.name == "Resonate":
		if $Sounds/Resonating.playing == false:
			$Sounds/Resonating.play()
	else:
		$Sounds/Resonating.stop()

func _on_resonance_timer_timeout() -> void:
	resonate()

func _on_resonance_cooldown_timer_timeout() -> void:
	canResonate = true


func _on_shatter_executed() -> void:
	for i in randi_range(1, 2):
		var b : HealthBuggy = buggy.instantiate()
		Game.addEnemy(b)
		b.position = global_position
		b.movement.applyForce(Vector2(randf_range(-0.3, 0.3), -1), 150)
