@tool
extends Resource
class_name DialogTree

const END_TARGET = "#end"

@export var dialogs : Dictionary[String,Dialog] = {}:
	set(new_setting):
			dialogs = new_setting
			_validate_dialog_tree(dialogs)
			#print("SET new dialog", new_setting)
			# Emit a signal when the property is changed.

func _validate_dialog_tree(tree:Dictionary[String,Dialog]):
	var keys = tree.keys()
	#print("All keys", keys)
	for key in tree:
		var dialog = tree.get(key) as Dialog
		#print("VAL", key, dialog)
		_validate_dialog(dialog,key,keys)
		
		

func _validate_dialog(dialog: Dialog,key:String, keys: Array[String]):
	for option in dialog.options:
		#print("VAL DIAL", option)
		if not (_validate_option(option,keys)):
			print("Unknown target '%s'" % option.target)
			print("Dialog: ",key, " Option Text: \"", option.text, "\"")
		
func _validate_option(option:DialogOption,  keys: Array[String]) -> bool:
	if option.target == END_TARGET:
		return true
	else:
		return option.target in keys
