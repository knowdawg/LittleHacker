extends CanvasLayer

func bluntHit():
	%AnimationPlayer.play("RESET")
	%AnimationPlayer.call_deferred("play","BluntHit")

func sharpHit():
	%AnimationPlayer.play("RESET")
	%AnimationPlayer.call_deferred("play", "SharpHit")

func block():
	%AnimationPlayer.play("RESET")
	%AnimationPlayer.call_deferred("play", "Block")

func guardBreak():
	%AnimationPlayer.play("RESET")
	%AnimationPlayer.call_deferred("play", "GaurdBreak")
