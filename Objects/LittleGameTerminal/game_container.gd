extends SubViewportContainer

func _ready() -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	get_viewport().set_input_as_handled()  # Swallow the event
