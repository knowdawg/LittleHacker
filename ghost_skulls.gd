extends Projectile

var offset := Vector2(0.0, -15.0)
func _process(_delta: float) -> void:
	if Game.doesPlayerExist():
		global_position = Game.player.global_position + offset

func customReady():
	$AnimationPlayer.play("ShowGhostSkulls")

func fireGhostSkulls():
	$AnimationPlayer.play("FireGhostSkulls")

var activeSkulls : int = 0
func setNextSkullActive():
	activeSkulls += 1
	
	if activeSkulls == 1:
		$Left.position.y = -offset.y
	if activeSkulls == 2:
		$Right.position.y = -offset.y
	if activeSkulls == 3:
		$Big.position.y = -offset.y
