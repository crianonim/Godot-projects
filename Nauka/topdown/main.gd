extends Node2D
class_name MainTopDown

var current_scene: Node = null
@onready var player: CharacterBody2D = $Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	change_scene("Village")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	debug_player_tile()

func change_scene(scene_name: String):
	var full_path = "res://topdown/%s.tscn" % scene_name
	var new_packed_scene: PackedScene = load(full_path)
	if new_packed_scene == null:
		push_error("There was a problem loading %s" % full_path)
		return
	if current_scene:
		current_scene.remove_child(player)
		current_scene.queue_free()
		add_child(player)

	var new_scene = new_packed_scene.instantiate()
	var player_start = new_scene.find_child("PlayerStart")
	
	
	
	if player_start:
		print(player_start.position)
		player.position = player_start.position

	current_scene = new_scene
	remove_child(player)
	new_scene.add_child(player)
	$WorldScene.add_child(new_scene)

func _input(event: InputEvent) -> void:
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
