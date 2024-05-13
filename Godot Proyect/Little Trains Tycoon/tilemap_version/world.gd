extends Node2D
@onready var tile_map :TileMap = $TileMap

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed:
			add_road(event.position)
			pass

func add_road(pos):
	var map_cell = tile_map.local_to_map(pos)
	tile_map.set_cell(1,map_cell,1,Vector2i(0,6), )
