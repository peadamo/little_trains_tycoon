extends Node2D
@onready var rail_controller = $"../.."

@onready var area_2d = $Area2D
@onready var white = $white


func _ready():
	white.visible = false

func _on_area_2d_mouse_entered():
	rail_controller.active_railpoint = $"."
	white.visible = true
	print("mouse enter")


func _on_area_2d_mouse_exited():
	white.visible = false
	
	print("mouse exit")
