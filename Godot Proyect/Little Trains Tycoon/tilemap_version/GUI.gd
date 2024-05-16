extends Control
@onready var world = $".."

@onready var temp_build_holder = $"../temp_build_holder"

const CAR_01 = preload("res://tilemap_version/cars/car_01.tscn")
var follow_mouse = false
func _unhandled_input(event):
	if follow_mouse:
		if event is InputEventMouseMotion:
			temp_build_holder.global_position=event.global_position
		if event is InputEventMouseButton:
			if event.button_index == 1 and event.pressed:
				var hover_city = null
				for city in $"../cities".get_children():
					if city.hover:
						hover_city = city
				
				if hover_city != null:
					world.add_car(hover_city)
					follow_mouse = false
			if event.button_index == 2 and event.pressed:
				follow_mouse = false
				for child in temp_build_holder.get_children():
					child.queue_free()
		

######### BUTTONS ################3

func _on_button_new_truck_pressed():
	if !follow_mouse : 
		follow_mouse=true
		temp_build_holder.add_child(CAR_01.instantiate())
