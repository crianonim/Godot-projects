extends Node2D
class_name MainTopDown

var current_scene: Node = null
@onready var player: CharacterBody2D = $Player
var scene_transitioning: bool = false
var paused : bool = false
@onready var world_scene: Node2D = $WorldScene
@onready var pause_menu: CanvasLayer = $UI/PauseMenu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	change_scene("village_2")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	debug_player_tile()
	pass

func change_scene(scene_name: String):
	print("Change scene", scene_name)
	var full_path = "res://topdown/%s.tscn" % scene_name
	var new_packed_scene: PackedScene = load(full_path)
	if new_packed_scene == null:
		push_error("There was a problem loading %s" % full_path)
		return
	if current_scene:
		print("Current scene", player)
		add_child(player)
		player.position=Vector2(-100,-100)
		current_scene.remove_child(player)
		current_scene.queue_free()
		

	var new_scene = new_packed_scene.instantiate()
	var player_start = new_scene.find_child("StartPosition")
	
	
	
	if player_start:
		print(player_start.position)
		player.position = player_start.position

	current_scene = new_scene
	remove_child(player)
	new_scene.add_child(player)
	world_scene.add_child(new_scene)
	var north_exit = new_scene.find_child("ExitNorth")
	if north_exit:
		north_exit.connect("body_entered",on_north_exit)
	print(north_exit)
	scene_transitioning=false

func pause_toggle():
	paused=!paused
	get_tree().paused=paused
	if paused:
		pause_menu.show()
	else:
		pause_menu.hide()
	
func on_north_exit(body: Node):
	print("Body exited north",body)
	if body == player:
		if scene_transitioning:
			return
		scene_transitioning=true
		print("Player exited")
		change_scene("farm_1")
		

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		#print("Pressed cancel")
		# It's the same tree, not a subtree
		#var wst=world_scene.get_tree()
		#print("Same?", wst, get_tree(), wst == get_tree())
		# Same?<SceneTree#34208744906><SceneTree#34208744906>true

		pause_toggle()
		
	if event is InputEventMouseButton:
		if event.pressed:
			var epos: Vector2 = event.position
			var gpos:Vector2 = to_global(epos)
			#print(epos,gpos)
			#print(current_scene)
			var tm: TileMapLayer=current_scene.find_child("TileMapLayer")
			#print(tm)
			var clicked_cell = tm.local_to_map(tm.get_local_mouse_position())
			#print(tm.get_local_mouse_position())
			var data = tm.get_cell_tile_data(clicked_cell)
			var cell_data=tm.get_cell_tile_data(gpos)
			#print(cell_data)
			#print(clicked_cell)
			#print(data)
			var glob = tm.to_local(gpos)
			#print("to_local", glob)
			#print(player.position)
			
func debug_player_tile() -> void:
	#print(player)
	var tm: TileMapLayer=current_scene.find_child("TileMapLayer")
	var clicked_cell: Vector2i = tm.local_to_map(player.position)
	var tile = tm.get_cell_atlas_coords(clicked_cell)
	var data: TileData = tm.get_cell_tile_data(clicked_cell)
	var damage_data: int = false
	if data:
		damage_data = data.get_custom_data("damage")
	#print("Player is at cell", tile, clicked_cell,damage_data)
	var selected_tile: ColorRect = tm.find_child("SelectedTile")
	
	var sel_tile_pos = clicked_cell * 16.0
	selected_tile.position= sel_tile_pos
	#print(sel_tile_pos)


func _on_resume_button_pressed() -> void:
	pause_toggle()


func _on_quit_button_pressed() -> void:
	get_tree().quit()
