class_name GameCamera
extends Camera3D

var ray_origin : Vector3
var ray_end : Vector3
@export var query_label : Label


func _physics_process(delta):
	ray_cast()
	
func ray_cast():
	var space_state = get_world_3d().direct_space_state
	var mouse_position = get_viewport().get_mouse_position()
	ray_origin = self.project_ray_origin(mouse_position)
	ray_end = ray_origin + (self.project_ray_normal(mouse_position) * 4000)
	var query = PhysicsRayQueryParameters3D.create(ray_origin, ray_end)
	var intersection = space_state.intersect_ray(query)
	
	if intersection.is_empty():
		query_label.text="none found"
	else:
		query_label.text=str(intersection.collider)
	#var ray_collider_name = intersection.get_collider()
	#
	#if intersection:
		#print(ray_collider_name)
