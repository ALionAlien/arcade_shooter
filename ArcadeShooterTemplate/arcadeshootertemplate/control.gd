extends Control

signal update_cursor

@export var draw_points : bool
@export var draw_cursor : bool
@export var layers : int = 4
@export var cursor_radius : float = 25
@export var point_count : int = 8 :
	set(value):
		print(value, " ", point_count)
		point_count = clampi(value, 1, 20)
@onready var game_camera : Camera3D = $".."
var points : Array
var mouse_position : Vector2

func _input(event):
	if event is InputEventMouseMotion:
		mouse_position = get_viewport().get_mouse_position()
		var divided_angle = 360/point_count
		var divided_layer_length = cursor_radius / layers
		points.clear()
		for n in layers:
			var current_layer_length = n * divided_layer_length
			for i in point_count:
				var current_angle = i * divided_angle
				points.append(calculate_point(mouse_position, current_layer_length, deg_to_rad(current_angle)))
			#points_label.text = str(points)
		update_cursor.emit(points)
		queue_redraw()

func calculate_point(origin:Vector2,length: float, angle_radians : float) -> Vector2:
	var x = length * cos(angle_radians)
	var y = length * sin(angle_radians)
	return origin + Vector2(x, y)

func _draw()->void:
	if draw_cursor:
		draw_arc(mouse_position, cursor_radius-6, 0, TAU, 64, Color.AZURE)
	if draw_points:
		for i in points:
			draw_circle(Vector2(i),2,Color.RED)

func _on_increase_points_button_pressed():
	point_count+=1

func _on_decrease_points_button_pressed():
	point_count-=1
