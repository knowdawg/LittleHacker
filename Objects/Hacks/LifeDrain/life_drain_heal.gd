extends HackCommandComponent

@export var parent : CharacterBody2D
@export var dmgTick : float = 1.0
@export var healthTick : float = 0.2
@export var tickLength : float = 0.2
@onready var e = $Dislocator/Effect

var active = false
var amountToDrain : int
var t = 0.0
func executeHack():
	active = true
	amountToDrain = healthComponent.get_weakness() + cost
	healthComponent.set_weakness(0.0)
	t = 0.0
	$Dislocator/AnimationPlayer.play("active")

func _process(delta: float) -> void:
	e.clear_points()
	if active:
		e.add_point(parent.global_position)
		e.add_point(Game.player.global_position)
		
		t += delta
		if t >= tickLength:
			t -= tickLength
			if amountToDrain <= 0:
				active = false
				$Dislocator/AnimationPlayer.stop()
				return
			amountToDrain -= 1
			
			var a : Attack = Attack.new()
			a.isParryable = false
			a.attack_damage = dmgTick
			
			healthComponent.damage(a)
			Game.player.heal(healthTick)
