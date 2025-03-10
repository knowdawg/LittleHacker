extends Node2D

@export var mirror : Sprite2D

var flip : bool = false
var followPlayer : bool = false

func _ready() -> void:
	$SmallHandAnimator.play("Idle")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if followPlayer and Game.player:
		global_position = lerp(global_position, Game.player.global_position, delta * 8.0)
		return
	else:
		position = lerp(position, Vector2(0,0), delta * 8.0)
	
	if flip != mirror.flip_h:
		flip = mirror.flip_h
		if flip == true:
			$SmallHandAnimator.play("Flip")
		else:
			$SmallHandAnimator.play("Flip2")
	

func doubleSwipe():
	$SmallHandAnimator.play("DoubleSwipe")

func clap():
	$SmallHandAnimator.play("Clap")

func setPlayerFollow(f : bool):
	followPlayer = f
	if !f:
		$SmallHandAnimator.play("Idle")
	if f:
		if flip == true:
			$SmallHandAnimator.play("Flip2")
			flip = false

func _on_small_hand_animator_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Flip" or anim_name == "Flip2":
		$SmallHandAnimator.play("Idle")


func _on_evicerate_hack_executed() -> void:
	if followPlayer:
		followPlayer = false
		$SmallHandAnimator.play("RESET")
