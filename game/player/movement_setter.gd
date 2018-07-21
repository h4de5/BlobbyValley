extends Control

export(NodePath) var scene
export var settings = ['mass', 'linear_damp', 'gravity_scale']

var current_element_id = 0

func _ready():
	call_deferred("initialize")

func initialize():
	var element
	var parent
	var i = 0
	parent = get_node(scene)

	for setting in settings:
		element = get_node("element_list/element_base").duplicate()
		element.name = "element_"+ str(i)
		element.visible = true
		element.get_node("name").text = setting + ":"

		if (parent.get(setting)):
			element.get_node("value").text =  str(parent.get(setting))
		else:
			element.get_node("value").text = "N/A"

		get_node("element_list").add_child(element)
		i += 1


var f_speed = 0
var v_movement = Vector2(0,0)

func _input(event):
	var element
	var element_value = 0.0

	if Input.is_action_just_pressed("ui_page_down"):
		current_element_id += 1
	elif Input.is_action_just_pressed("ui_page_up"):
		current_element_id -= 1

	if Input.is_action_pressed("ui_end"):
		element_value += 1
	if Input.is_action_pressed("ui_home"):
		element_value -= 1

	if current_element_id < 0:
		current_element_id = settings.size() - 1
	if current_element_id >= settings.size() :
		current_element_id = 0

	for i in range(0, settings.size()):
		element = get_node("element_list/element_"+ str(i))
		if i == current_element_id:
			element.modulate = Color(1,0,0)

			if element_value != 0:
				set_element_value(current_element_id, element, element_value)

		else:
			element.modulate = Color(1,1,1)





func set_element_value(element_id, element, set_value):

	var current_value = 0
	var parent = get_node(scene)

	current_value = parent.get(settings[element_id])

	if current_value <= 1.0:
		set_value /= 100

	element.get_node("value").text = str(current_value + set_value)
	parent.set(settings[element_id], current_value + set_value)


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