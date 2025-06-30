@tool
extends CollisionShape3D

@export var mesh : MeshInstance3D
#@export var size : Vector3

func _set(property, value):
	if property == "position":
		print("s")
