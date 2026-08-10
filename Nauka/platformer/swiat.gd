extends Node2D

const ENEMY = preload("uid://2oqfqxx5b61g")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed:
			var enemy: Node2D = ENEMY.instantiate()
			enemy.position = event.position
			enemy.name = "Yesod"
			add_child(enemy)
			print(enemy)
			
			
