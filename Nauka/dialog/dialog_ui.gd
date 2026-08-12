extends Control
@onready var text: Label = $Panel/MarginContainer/VBoxContainer/Text
@onready var options_container: VBoxContainer = $Panel/MarginContainer/VBoxContainer/OptionsContainer

@export var root: Dialog
var current_dialog : Dialog
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_dialog = root
	setup_dialog(current_dialog)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func setup_dialog(dialog: Dialog) -> void:
	text.text = dialog.text
	for child in options_container.get_children():
		child.queue_free()
	for option in dialog.options:
		var optionLabel = Button.new()
		optionLabel.text = option.text
		optionLabel.pressed.connect(on_button_pressed_option.bind(option.target))
		options_container.add_child(optionLabel)
		
		
func on_button_pressed_option(dialog: Dialog) -> void:
	current_dialog = dialog
	setup_dialog(dialog)
