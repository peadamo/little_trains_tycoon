extends Path2D
@onready var rail : Path2D = $"."
@onready var line_2d : Line2D = $Line2D




func update_rail_texture():
	var path_points = rail.curve.get_baked_points()
	line_2d.clear_points()
	line_2d.points = path_points
