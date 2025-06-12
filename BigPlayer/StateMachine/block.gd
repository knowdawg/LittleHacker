extends State
class_name BigPlayerBlock

@export var animator : AnimationPlayer
@export var parent : BigPlayer
@export var stateMachine : BigPlayerStateMachine
@export var hurtbox : HurtboxComponent

var t := 0.0
func enter(_p):
	t = 0.0
	animator.play("Block")
	hurtbox.setBlock(true)
	hurtbox.setParry(true, 1)

func update(delta):
	t += delta
	if t >= 0.2:
		hurtbox.setParry(false)
	
	if stateMachine.getInputBuffer() == "Attack":
		trasitioned.emit(self, "AttackCharge")
		return
	
	if !Input.is_action_pressed("Parry"):
		trasitioned.emit(self, "LeaveBlock")
		return

func exit(_n):
	hurtbox.setBlock(false)
	hurtbox.setParry(false)


func _on_hurtbox_component_blocked(a: Attack) -> void:
	if stateMachine.current_state is BigPlayerBlock:
		animator.play("onBlock")


func _on_hurtbox_component_parry(a: Attack) -> void:
	if stateMachine.current_state is BigPlayerBlock:
		animator.play("onParry")
