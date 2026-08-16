extends Control
@onready var text: Label = $Panel/MarginContainer/VBoxContainer/Text
@onready var options_container: VBoxContainer = $Panel/MarginContainer/VBoxContainer/OptionsContainer

@export var dialogs: DialogTree
var expression : Expression = Expression.new()

var state : Dictionary = { 
	"flags": {
		"met_bob": true,
		"offended_kate": false
		
	},
	"money" : 100,
	"name": "Jan"
}
signal finished
var current_dialog : Dialog
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_dialog = dialogs.dialogs.get("#start")
	setup_dialog(current_dialog)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func setup_dialog(dialog: Dialog) -> void:
	print("Setting up", dialog)
	text.text = dialog.text
	for child in options_container.get_children():
		child.queue_free()
	for option in dialog.options:
		var can_show = can_show_option(option)
		print("Can show? '", option.show_if_text, "' :", can_show)
		if not can_show:
			continue
		var optionLabel = Button.new()
		optionLabel.text = option.text
		print(option.target)
		optionLabel.pressed.connect(on_button_pressed_option.bind(option.target))
		options_container.add_child(optionLabel)
		

func on_button_pressed_option(target: String) -> void:
	print("Selected", target)
	if target == DialogTree.END_TARGET:
		finished.emit()
		# Close for now
		get_tree().quit() 
		return
	
	current_dialog = dialogs.dialogs.get(target)
	setup_dialog(current_dialog)

func can_show_option(option: DialogOption) -> bool:
	if option.show_if_text==null:
		return true
	else:
		var error = expression.parse(option.show_if_text,["state"])
		if error != OK:
			print("ERROR:")
			print(expression.get_error_text())
			return false
		else:
			var result = expression.execute([state])
			print("Result ",result)
			return result
