extends Control

export(NodePath) var scene
export var settings = ['mass', 'linear_damp', 'gravity_scale', 'v_movement', 'gravity']

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
		if i == 0:
			element.modulate = Color(1,0,0)
		element.visible = true
		element.get_node("name").text = setting + ":"

		if (parent.get(setting) != null):
			element.get_node("value").text =  str(parent.get(setting))
		else:
			element.get_node("value").text = "N/A"

		get_node("element_list").add_child(element)
		i += 1


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
		if element != null:
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

	if current_value != null:
		if current_value <= 1.0:
			set_value /= 100

		element.get_node("value").text = str(current_value + set_value)
		parent.set(settings[element_id], current_value + set_value)

