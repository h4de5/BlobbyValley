extends RigidBody2D

var v_movement = Vector2(0,0);
var f_speed = 25

func _ready():
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _process(delta):
	if(v_movement.x != 0 || v_movement.y != 0):
		#add_force(Vector2(0,0), v_movement)
		apply_impulse(Vector2(0,0), v_movement)

func touches_ground():

	# des not realy work that way
	return true
	var bodies = get_colliding_bodies()
	if (get_parent().get_node("field/floor") in bodies):
		return true
	else:
		return false


func _input(event):
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
