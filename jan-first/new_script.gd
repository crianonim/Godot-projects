extends Node2D


var elapsed:float = 0;
@export var multiplier : float =1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Ready with multiplier"+str(multiplier))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	elapsed+=(delta*multiplier)
	#print("process"+str(elapsed))
