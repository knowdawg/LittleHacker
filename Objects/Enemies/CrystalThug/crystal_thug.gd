extends CharacterBody2D

@export var projectile : PackedScene

var canResonate : bool = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$GeneralComponents/HealthComponent.hit.connect(checkResonanceHit)
	
func checkResonanceHit(attack : Attack):
	if attack.attackName == "CrystalResonanceBlast":
		if canResonate:
			$ResonanceTimer.start()
			canResonate = false
			$ResonanceCooldown.start()

func resonate():
	var p = projectile.instantiate()
	Game.level.add_child(p)
	p.position = global_position


func _on_resonance_timer_timeout() -> void:
	resonate()

func _on_resonance_cooldown_timeout() -> void:
	canResonate = true
