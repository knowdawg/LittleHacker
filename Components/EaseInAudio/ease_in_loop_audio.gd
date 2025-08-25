extends FollowAudio
class_name EasiInLoopAudio

@export var easeInTime : float = 0.3
@export var easeOutTime : float = 0.3

func playSound():
	volume_db = -80.0
	$AnimationPlayer.speed_scale = 1.0 / easeInTime
	$AnimationPlayer.play("EaseIn")
	play()

func endSound():
	volume_db = 0.0
	$AnimationPlayer.speed_scale = 1.0 / easeOutTime
	$AnimationPlayer.play("EaseOut")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "EaseOut":
		stop()
