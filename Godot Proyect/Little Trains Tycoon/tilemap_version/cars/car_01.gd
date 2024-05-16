extends CharacterBody2D

@export var origin : Node2D
@export var destination : Node2D
@export var speed = 3000
@onready var navigation_agent_2d :NavigationAgent2D= $NavigationAgent2D
@onready var sprite_2d = $Sprite2D
var cargo = null
var actual_city = null
enum {
	STOP,
	CARRING,
	WAITING,
	PICKING,
}

var state = STOP

func _process(delta):
	if state != STOP and state != WAITING:
		visible = true
		velocity = Vector2.ZERO
		if navigation_agent_2d.is_target_reachable():
			if state == PICKING:
				var distance = global_position.distance_to(origin.global_position)
				if distance > 10 :
					var path_point = navigation_agent_2d.get_next_path_position()
					var direction = round(global_position.direction_to(path_point)) 
					if direction.x < 0:
						sprite_2d.flip_h=true
					elif direction.x > 0 :
						sprite_2d.flip_h=false
					elif direction.x == 0 :
						sprite_2d.flip_h=false
					if direction.y < 0:
						sprite_2d.rotation=deg_to_rad(-90)
					elif direction.y > 0 :
						sprite_2d.rotation=deg_to_rad(90)
					elif direction.y == 0 :
						sprite_2d.rotation=deg_to_rad(0)
					velocity = direction*delta*speed
					
				else :
					state = CARRING
					navigation_agent_2d.set_target_position(destination.global_position)
					
			if state == CARRING:
				var distance = global_position.distance_to(destination.global_position)
				if distance > 10 :
					var path_point = navigation_agent_2d.get_next_path_position()
					var direction = round(global_position.direction_to(path_point)) 
					if direction.x < 0:
						sprite_2d.flip_h=true
					elif direction.x > 0 :
						sprite_2d.flip_h=false
					elif direction.x == 0 :
						sprite_2d.flip_h=false
					if direction.y < 0:
						sprite_2d.rotation=deg_to_rad(-90)
					elif direction.y > 0 :
						sprite_2d.rotation=deg_to_rad(90)
					elif direction.y == 0 :
						sprite_2d.rotation=deg_to_rad(0)
					velocity = direction*delta*speed
					
				else :
					state = WAITING
					destination.remove_from_needed(cargo)
					destination.car_count+=1
					destination.add_in_city_car_marker()
			move_and_slide()
	else:
		visible = false
		
