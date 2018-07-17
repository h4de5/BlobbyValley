extends Control

export(NodePath) var scene

var settings = ['weight']


func _ready():

	call_deferred("initialize")

#
func initialize():
	var element
	element = get_node("element_list/element_base").duplicate()

	var parent
	parent = get_node(scene.get_as_property_path())
	print("scene set via editor: ", scene)
	print("found path of parent: ", scene.get_as_property_path())

	for setting in settings:
		#element.new()
		element.visible = true
		element.get_node("name").text = setting

		print("create element line for setting: ", setting)

		#element.get_node("value").text = get_tree().get_root().get_node(scene.get_as_property_path()).get("weight")
		if (parent.get(setting)):
			element.get_node("value").text = parent.get(setting)

		get_node("element_list").add_child(element)


var f_speed = 0
var v_movement = Vector2(0,0)

func _input(event):
	pass


func notinuse(event):
	var move_forward = 0
	var move_backward = 0
	var move_up = 0
	var move_down = 0

	# Move right
	if Input.is_action_pressed("ui_right"):
		move_forward = f_speed
	elif Input.is_action_just_released("ui_right"):
		move_forward = 0

	if Input.is_action_pressed("ui_left"):
		move_backward = -f_speed
	elif Input.is_action_just_released("ui_left"):
		move_backward = 0

	if Input.is_action_just_pressed("ui_up") && touches_ground():
		move_up = -f_speed*2
	elif Input.is_action_just_released("ui_up"):
		move_up = 0

	if Input.is_action_pressed("ui_down"):
		move_down = f_speed/2;
	elif Input.is_action_just_released("ui_down"):
		move_down = 0

	if(move_forward + move_backward != 0):
		v_movement.x = move_forward + move_backward
	else:
		v_movement.x = 0

	if(move_up + move_down != 0):
		v_movement.y = move_up + move_down
	else:
		v_movement.y = 0