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
	var index = item_need.find(item)
	item_need.remove_at(index)


var hover = false

func _on_area_2d_mouse_entered():
	$resalt_circle.visible = true
	hover = true
	pass # Replace with function body.

@onready var v_box_container = $Control/VBoxContainer

func _on_area_2d_mouse_exited():
	$resalt_circle.visible = false
	hover = false
	
@onready var car_counter = $Control/VBoxContainer/car_display/car_counter

func add_in_city_car_marker():
	car_count+=1
	car_counter.text = str(" x ",car_count)
		
		
func remove_in_city_car_marker():
	car_count-=1
	car_counter.text = str(" x ",car_count)

	
var carrot_counter = 0
@onready var carrot_counter_label = $Control/VBoxContainer/carrot_display/carrot_counter_label

func update_storage():
	carrot_counter=0
	for item in storage:
		match item :
			"carrot":
				carrot_counter+=1
	carrot_counter_label.text = str(" x ",carrot_counter)
	

func _on_timer_timeout():
	if type == build_type.FARM:
		storage.append("carrot")
	if type == build_type.CITY:
		if item_need.size()<5:
			item_need.append("carrot")
	update_storage()
		
func remove_carrot():
	storage.remove_at(0)
	update_storage()

