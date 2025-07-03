class_name GameCamera
extends Camera3D

var ray_origin : Vector3
var ray_end : Vector3
@export var query_label : Label
@export var found_nodes_label : RichTextLabel
@export var final_node_label : Label
var found_nodes : Dictionary = {}
var target : Node3D :
	set(value):
		update_target(target, value)
		target = value

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _physics_process(delta):
	camera_ray_cast(Vector2(2,2))

func _raycast_points(points):
	found_nodes.clear()
	for i in points:
		var cast_result = camera_ray_cast(i)
		if cast_result:
			if found_nodes.has(cast_result):
				found_nodes[cast_result] +=1
			else:
				found_nodes[cast_result] = 1
				
	found_nodes_label.text = str(found_nodes)
	
	var sorted_keys : Array = found_nodes.keys()
	sorted_keys.sort_custom(func(a,b):
		return found_nodes[b] < found_nodes[a]
	)
	#save the result of the sort
	if sorted_keys:
		target = sorted_keys[0]
	else:
		target = null

func update_target(old_target, new_target) -> void:
	if old_target != new_target:
		if old_target and old_target.has_user_signal("unfocused"):
			print(str(old_target) + "unfocused")
			old_target.emit_signal("unfocused")
		if new_target and new_target.has_user_signal("focused"):
			print(str(new_target)+ "focused")
			new_target.emit_signal("focused")

func camera_ray_cast(origin : Vector2):
	var space_state = get_world_3d().direct_space_state
	ray_origin = self.project_ray_origin(origin)
	ray_end = ray_origin + (self.project_ray_normal(origin) * 4000)
	var query = PhysicsRayQueryParameters3D.create(ray_origin, ray_end)
	var intersection = space_state.intersect_ray(query)
	
	if intersection.is_empty():
		return
	else:
		if intersection.collider.is_in_group("Targetable"):
			return intersection.collider
