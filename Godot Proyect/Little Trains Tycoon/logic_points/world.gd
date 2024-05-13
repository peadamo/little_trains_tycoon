extends Node2D
@onready var rails = $rails

var active_railpoint = null
var last_rail :Path2D

const RAIL = preload("res://logic_points/rail.tscn")


func _unhandled_input(event):
	
# New rail_line_creation
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed:
			if is_creating_new_rail == false:
				if active_railpoint != null:
					create_new_rail()
			else :
				place_rail_point(event.global_position)
		
		if event.button_index == 2 and !event.pressed:
			end_new_rail()
				
	if event is InputEventMouseMotion:
		if is_creating_new_rail:
			update_new_railLine_pos(event.global_position)


var is_creating_new_rail = false
func create_new_rail():
	is_creating_new_rail=true
	#crea el nuevo rail
	rails.add_child(RAIL.instantiate())
	last_rail = rails.get_child(-1)
	last_rail.curve.add_point(active_railpoint.global_position)
	last_rail.curve.add_point(active_railpoint.global_position)
	
	
func update_new_railLine_pos(new_pos):
	var total_points = last_rail.curve.point_count
	var point_idx = total_points-1
	last_rail.curve.set_point_position(point_idx,new_pos)
	last_rail.update_rail_texture()
	print(last_rail.curve.get_baked_length())
	
	
	
	
@onready var rail_points = $rail_points

const RAIL_POINT = preload("res://logic_points/rail_point.tscn")

var last_added_rail_point = null

func place_rail_point(new_pos):
	rail_points.add_child(RAIL_POINT.instantiate())
	last_added_rail_point = rail_points.get_child(-1)
	last_added_rail_point.global_position = new_pos
	
	last_rail.curve.add_point(new_pos)
	
func end_new_rail():
	var total_points = last_rail.curve.point_count
	var point_idx = total_points-1
	last_rail.curve.remove_point(point_idx)
	last_rail.update_rail_texture()
	is_creating_new_rail = false
	
	
