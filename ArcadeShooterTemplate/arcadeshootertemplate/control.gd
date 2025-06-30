extends Control

var mouse_position : Vector2
var point_count : int = 4 :
	set(value):
		print(value, " ", point_count)
		point_count = clampi(value, 4, 20)
var cursor_radius : float = 15
var points : Array
@export var points_label : Label

func _input(event):
	if event is InputEventMouseMotion:
		mouse_position = get_viewport().get_mouse_position()
		var divided_angle = 360/point_count
		points.clear()
		for i in point_count:
			var current_angle = i * divided_angle
			points.append(calculate_point(mouse_position, cursor_radius, deg_to_rad(current_angle)))
		points_label.text = str(points)
		queue_redraw()

func calculate_point(origin:Vector2,length: float, angle_radians : float) -> Vector2:
	var x = length * cos(angle_radians)
	var y = length * sin(angle_radians)
	return origin + Vector2(x, y)

func _draw()->void:
	for i in points:
		draw_circle(Vector2(i),2,Color.RED)

func _on_increase_points_button_pressed():
	point_count+=1

func _on_decrease_points_button_pressed():
	point_count-=1
