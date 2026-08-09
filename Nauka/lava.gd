extends Area2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	print("Lava _on_body_entered")
	if body.has_method('on_fell_into_lava'):
		print("Found on_fell_into_lava")
		body.on_fell_into_lava()
	else:
		print("Didn't find on_fell_into_lava in %s" % body)
