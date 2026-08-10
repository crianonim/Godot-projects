extends CharacterBody2D


const SPEED = 50.0

var survived : float = 0

func _physics_process(delta: float) -> void:
	
	survived = survived + delta
	
	var input_direction := Input.get_vector("ui_left", "ui_right", "ui_up","ui_down")
	velocity = input_direction * SPEED
	#if input_direction != Vector2.ZERO:
		#print("Vel:",velocity)
	$Label.text=str(int(survived))
	move_and_slide()
