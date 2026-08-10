extends CharacterBody2D


const SPEED = 50.0



func _physics_process(delta: float) -> void:
	

	
	var input_direction := Input.get_vector("ui_left", "ui_right", "ui_up","ui_down")
	velocity = input_direction * SPEED
	#if input_direction != Vector2.ZERO:
		#print("Vel:",velocity)

	move_and_slide()
