extends Node
class_name Main

var current_scene: Node = null
@onready var player: CharacterBody2D = $CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Main")
	Game.player = player
	change_scene("res://platformer/swiat.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_down"):
		print("Down pressed")
		change_scene("res://platformer/swiat_2.tscn")

func change_scene(scene: String):
	var new_packed_scene: PackedScene = load(scene)
	if new_packed_scene == null:
		push_error("There was a problem loading %s" % scene)
		return
	if current_scene:
		current_scene.remove_child(player)
		current_scene.queue_free()
		add_child(player)

	var new_scene = new_packed_scene.instantiate()
	var player_start = new_scene.find_child("PlayerStart")

	print(player_start.position)
	if player_start:
		player.position = player_start.position

	current_scene = new_scene
	remove_child(player)
	new_scene.add_child(player)
	$Scene2d.add_child(new_scene)
