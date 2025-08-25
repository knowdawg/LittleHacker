extends Enemy
class_name RemnantCrab

signal landed
signal impact

func _on_state_machine_state_switched(prevState: State, newState: State) -> void:
	if newState.name == "StompRight":
		%Legs.flip_h = true
	if prevState:
		if prevState.name == "StompRight":
			%Legs.flip_h = false

func _ready() -> void:
	%HeartAnimator.play("Beat")

func _physics_process(delta: float) -> void:
	velocity.y += 1000.0 * delta
	
	if is_on_floor():
		if velocity.y > 0:
			velocity.y = 0
	
	move_and_slide()

func smallImpact():
	impact.emit()

func bigImpact():
	landed.emit()

func launch():
	velocity.y = -5000.0

func prepareForLanding():
	if Game.doesPlayerExist():
			global_position.x = Game.player.global_position.x

func launchLand():
	if %DownCast.is_colliding():
		global_position.y = %DownCast.get_collision_point().y - 23.0
		landed.emit()
	
	if legsBroken:
		var a : Attack = Attack.new()
		a.attack_damage = 5.0
		a.knockback_vector = a.getRandomNormalizedVector(-PI, PI)
		healthComponent.damage(a)

var swordProjectile = preload("uid://c7xd4741m8qkc")
func createStompProjectile():
	var p : Projectile = swordProjectile.instantiate()
	p.speed = 240.0
	var offset := Vector2(0.0, 23.0)
	if %Legs.flip_h:
		p.dirVector = Vector2(1.0, 0.0)
		offset += Vector2(23.0, 0.0)
	else:
		p.dirVector = Vector2(-1.0, 0.0)
		offset += Vector2(-23.0, 0.0)
	p.flipH = %Legs.flip_h
	p.global_position = global_position + offset
	Game.addProjectile(p)


func GravityAmpLeftStomp():
	var p : CrystalEliteProjectile = swordProjectile.instantiate()
	p.speed = 240.0
	var offset := Vector2(-23.0, 23.0)
	p.recal = true
	p.recalVec = Vector2(-1.0, 0.0)
	p.dirVector = Vector2(-1.0, 0.0)
	p.flipH = false
	p.global_position = global_position + offset
	Game.addProjectile(p)

func GravityAmpRightStomp():
	var p : CrystalEliteProjectile = swordProjectile.instantiate()
	p.speed = 240.0
	var offset := Vector2(23.0, 23.0)
	p.recal = true
	p.recalVec = Vector2(1.0, 0.0)
	p.dirVector = Vector2(1.0, 0.0)
	p.flipH = true
	p.global_position = global_position + offset
	Game.addProjectile(p)


var laserPillarProjectile = preload("uid://d0sqdwt14okl0")
func createLaserPillars(numOfPillars : int = 14, maxDis : float = 100.0):
	for i in range(numOfPillars):
		var p : LaserPillar = laserPillarProjectile.instantiate()
		p.global_position = global_position + Vector2(randf_range(-maxDis, maxDis), 23.0)
		Game.addProjectile(p)
		p.speedScale = randf_range(0.7, 1.0)
		p.activate()


func suckInPlayer(delta, amount : float = 5.0, fromVisual : bool = false):
	if Game.doesPlayerExist():
		var targetPos : float = global_position.x
		if fromVisual:
			targetPos = %BlackHole.global_position.x
		Game.player.global_position.x = lerpf(Game.player.global_position.x, targetPos, delta * amount)
		if Game.doesCameraExist():
			Game.camera.set_min_shake(1.0)


func shakeScreen(amount : float = 5.0):
	if Game.doesCameraExist():
		Game.camera.set_min_shake(amount)


func kill():
	healthComponent.kill()

func makeBlackHoleSafe():
	%BlackHoleColorChanger.play("Safe")

func makeBlackHoleDangerous():
	%BlackHoleColorChanger.play("Dangerous")

func staggerEffect():
	%BigStaggerEffect.effect()
	Game.freezeFrame(0.1)
	Game.shakeCameraLittleGame(10.0)

func _on_jump_slam_got_parried(a : Attack) -> void:
	if $StateMachine.current_state.name == "Jump":
		if Game.doesPlayerExist():
			Game.superParry(Game.player)

func _on_jump_slam_black_hole_got_parried(a: Attack) -> void:
	if $StateMachine.current_state.name == "Jump2":
		if Game.doesPlayerExist():
			Game.superParry(Game.player)
			%StateMachine.switchStates("StaggerPhase2")

func _on_health_component_on_lock_hit(lockName : String) -> void:
	if lockName == "PhaseTransition":
		%StateMachine.switchStates("PhaseSwitch")
		%StateMachine.switchPhases()
		$StateMachine/Idle.nextStates.clear()
		staggerEffect()


func _on_health_component_hit(attack: Attack) -> void:
	var t : Tween = create_tween()
	if %StateMachine.phase == 1:
		%Phase1Hit.playSound()
		%Phase1BoneHit.playSound()
		%Skulls.offset = attack.knockback_vector * 10.0
		t.tween_property(%Skulls, "offset", Vector2.ZERO, 0.1).set_ease(Tween.EASE_OUT)
	
	if %StateMachine.phase == 2:
		%Phase2Hit.playSound()
		%Heart.offset = attack.knockback_vector * 5.0
		t.tween_property(%Heart, "offset", Vector2.ZERO, 0.1).set_ease(Tween.EASE_OUT)
		%CageAnimator.stop()
		%CageAnimator.play("Hit")

var legsBroken : bool = false
func _on_break_legs_executed() -> void:
	legsBroken = true


var biteFrames : Array[int] = [17, 32]
func _on_skulls_frame_changed() -> void:
	for i in biteFrames:
		if %Skulls.frame == i:
			%Bite.playSound()
