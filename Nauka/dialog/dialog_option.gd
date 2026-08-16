extends Resource
class_name DialogOption

@export var text: String = "Option text"
@export var target: String = "#end"
@export var show_if_text: String = "true":
	set(val):
		show_if_text=val
		#var expression : Expression = Expression.new()
		#
		#print("Given", val)
		#var error = expression.parse(val,["state"])
		#if error != OK:
			#print("ERROR:")
			#print(expression.get_error_text())
		#else:
			#var result = expression.execute([{"flags":{"met_bob":true}}])
			#print("Result ",result)
	
