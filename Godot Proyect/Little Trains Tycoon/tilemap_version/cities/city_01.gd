extends Node2D

@export var need = false
@export var has = false
var car_count = 0
enum build_type {FARM,CITY}
@export var type = build_type.CITY
const TILE_0086 = preload("res://tilemap_version/cities/tile_0086.png")
func _ready(): 
	if type == build_type.FARM :
		$Sprite2D.texture = TILE_0086
	
	



var item_need : Array = []
var storage : Array = []


func remove_from_needed(item):
	print("remove item",item)
	var index = item_need.find(item)
	print(index)
	item_need.remove_at(index)
	print(item_need)


var hover = false

func _on_area_2d_mouse_entered():
	$resalt_circle.visible = true
	hover = true
	pass # Replace with function body.

@onready var v_box_container = $Control/VBoxContainer

func _on_area_2d_mouse_exited():
	
	$resalt_circle.visible = false
	hover = false
	
const IN_CITY_CAR_MARKER = preload("res://tilemap_version/GUI/IN_CITY_CAR_MARKER.tscn")	
const H_BOX_CONTAINER = preload("res://tilemap_version/GUI/h_box_container.tscn")
func add_in_city_car_marker():
	
	var h_containers = v_box_container.get_children()
	var h_located = false
	for h_container in h_containers:
		if h_container.get_child_count() < 5:
			h_container.add_child(IN_CITY_CAR_MARKER.instantiate())
			h_located = true
			print("car located",h_container)
			break
	if !h_located :
		v_box_container.add_child(H_BOX_CONTAINER.instantiate())
		v_box_container.get_child(-1).add_child(IN_CITY_CAR_MARKER.instantiate())
		
		
func remove_in_city_car_marker():
	
	var last_H_cont = v_box_container.get_child(-1)
	last_H_cont.get_child(-1).queue_free()
	if last_H_cont.get_child_count() == 0 :
		last_H_cont.queue_free()
	


func _on_timer_timeout():
	print("city timer")
	if type == build_type.FARM:
		storage.append("carrot")
		storage.append("carrot")
	if type == build_type.CITY:
		item_need.append("carrot")

