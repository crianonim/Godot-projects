class_name Enemy
extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_fell_into_lava() -> void:
	print("%s fell into lava!" % self)
	queue_free()
