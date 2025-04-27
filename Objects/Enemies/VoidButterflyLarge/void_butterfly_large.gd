@tool
extends Enemy

@export var startingRotation : float = 0.0

func customReady() -> void:
	randomize()
	$Animator.speed_scale = randf_range(0.7, 1.3)
	if randf() < 0.5:
		$Sprite2D/SpriteDirectorComponent.flipXDir()
	
	if SaveDataManager.saveData.abilities.get("VoidPin") == true:
		$StateMachine/Idle.playerProximity = null

func onSelectedForGrappleTarget():
	$GrappleDisapearTimer.start()
	$StateMachine.switchStates("FlyAway")


func _process(_delta: float) -> void:
	$Sprite2D.rotation_degrees = startingRotation
	if !Engine.is_editor_hint():
		if $StateMachine.current_state.name == "FlyAway" or $StateMachine.current_state.name == "Death":
			$Sprite2D.rotation_degrees = 0.0

func canBeGrappledTo() -> bool:
	if $StateMachine.current_state.name == "Death":
		return false
	return true

func onPlayerStuckToMeWithGrapple():
	killSelf()

func _on_grapple_disapear_timer_timeout() -> void:
	killSelf()

func killSelf():
	var a := Attack.new()
	a.attack_damage = 1.0
	
	$GeneralComponents/HealthComponent.damage(a)
