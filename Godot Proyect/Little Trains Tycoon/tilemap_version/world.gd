extends Node2D
@onready var tile_map :TileMap = $TileMap


func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed:
			add_road(event.position)
			pass
			
		if event.button_index == 2 and event.pressed:
			delete_road(event.position)
			
func add_road(pos):
	var map_cell = tile_map.local_to_map(pos)
	tile_map.set_cell(0,map_cell,1,Vector2i(0,6))

func delete_road(pos):
	var map_cell = tile_map.local_to_map(pos)
	tile_map.set_cell(0,map_cell,-1,Vector2i(-1,-1))



@onready var cities = $cities
@onready var vehicles = $vehicles
const CAR_01 = preload("res://tilemap_version/cars/car_01.tscn")

enum {
	STOP,
	CARRING,
	WAITING,
	PICKING,
}

func _on_timer_timeout():
	for city_A in cities.get_children():
		if city_A.item_need.size() > 0:
			for needed_item in city_A.item_need:
				for city_B in cities.get_children():
					if city_B.storage.has(needed_item):
						
						var selected_car = null
						var distance = 999999999
						
						for car in vehicles.get_children():
							if car.state == WAITING:
								var car_dist = car.global_position.distance_to(city_B.global_position)
								if car_dist < distance:
									selected_car = car
									distance = car_dist
									
						if selected_car != null:
							selected_car.navigation_agent_2d.set_target_position(city_B.global_position)
							if selected_car.navigation_agent_2d.is_target_reachable():
								
								selected_car.origin = city_B
								selected_car.destination = city_A
								selected_car.state = PICKING
								selected_car.cargo = needed_item
								selected_car.actual_city.remove_in_city_car_marker()
								print(selected_car," - ori:",city_B," - dest:",city_A," - state",selected_car.state)
						
				
@onready var temp_build_holder = $temp_build_holder
				
func add_car(hover_city):
	var car = temp_build_holder.get_child(-1)
	car.reparent(vehicles)
	car.global_position = hover_city.global_position
	hover_city.add_in_city_car_marker()
	car.state = WAITING
	car.actual_city = hover_city
	car.visible = false
