class_name InteractableComponent
extends Node

var parent
@export var mesh : MeshInstance3D
var highlight_material = preload("res://highlight_material_overlay.tres")

func _ready() -> void:
	parent = get_parent()
	connect_parent()

func connect_parent() -> void:
	parent.add_user_signal("focused")
	parent.add_user_signal("unfocused")
	parent.add_user_signal("interacted")
	parent.connect("focused", Callable(self, "on_hover"))
	parent.connect("unfocused", Callable(self, "leave_hover"))
	parent.connect("interacted", Callable(self, "on_interact"))

func on_hover() -> void:
	mesh.material_overlay = highlight_material
 
func leave_hover() -> void:
	mesh.material_overlay = null

func on_interact() -> void:
	pass
