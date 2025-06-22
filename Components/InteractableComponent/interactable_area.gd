extends Area2D
class_name InteractableComponent

@export var text : String = ""
@export var textPos : Marker2D
@export var colShape : CollisionShape2D
@export var disableOnInteract : bool = false

signal onInteract
signal onSelect
signal onDeSelect

func interact():
	onInteract.emit()
	if disableOnInteract:
		disable()

func _ready() -> void:
	$RichTextLabel.text = "[center]" + text
	if textPos:
		$RichTextLabel.position = textPos.position + Vector2(-50, -8)

var stayVisible : bool = false
func select():
	onSelect.emit()
	stayVisible = true
	$RichTextLabel.visible = true

func deSelect():
	onDeSelect.emit()
	stayVisible = false
	$RichTextLabel.visible = false

func disable():
	colShape.disabled = true

func enable():
	colShape.disabled = false

func _process(_delta: float) -> void:
	$RichTextLabel.text = "[center]" + text
	if !stayVisible:
		$RichTextLabel.visible = false
	else:
		deSelect()
		
