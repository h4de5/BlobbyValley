extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("field/field_left").add_to_group("FLOOR")
	get_node("field/field_right").add_to_group("FLOOR")



