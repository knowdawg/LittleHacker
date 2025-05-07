extends Projectile

var distTaveled : float = 0.0
var disJump : float = 12.0

var t = 0.0
func _process(delta: float) -> void:
	distTaveled += abs(delta * speed * dirVector.x)
	if distTaveled >= disJump:
		distTaveled -= disJump
		global_position.x += disJump * Vector2(dirVector.x, 0.0).normalized().x
		$Transform/Sprite2D.frame = 0
		t = 0.0
		#$AttackComponent.generateAttackID()
	
	#$Transform/Sprite2D.frame = floor((distTaveled / disJump) * 3.0)
	t += delta
	if $Transform/Sprite2D.frame == 2:
		if t >= 0.1:
			$Transform/Sprite2D.frame += 1
	else:
		if t >= 0.05 and $Transform/Sprite2D.frame < 6:
			$Transform/Sprite2D.frame += 1
	
	if $Transform/Sprite2D.frame >= 1:
		$AttackComponent.enable()
	else:
		$AttackComponent.disable()
