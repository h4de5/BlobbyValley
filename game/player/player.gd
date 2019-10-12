#extends RigidBody2D
extends KinematicBody2D

var v_movement = Vector2(0,0);
var f_jump = 200
var f_move = 200
var gravity = 9.81
var linear_damping = 0.92

var b_left = 0
var b_right = 0
var b_up = 0
var b_down = 0

func _ready():
#	add_collision_exception_with(get_node("hackydihack"))
	pass


# func _physics_process(delta):
func _physics_process(delta):

	v_movement = Vector2(b_right + b_left, b_up + b_down)


	# see: https://godotengine.org/qa/11812/can-kinematicbody-move-not-block-on
	var left_over_motion = Vector2(0,0)
	#if(v_movement.x != 0 || v_movement.y != 0):
		# add_force(Vector2(0,0), v_movement)

		# apply_impulse(Vector2(0,0), v_movement)
		# move_and_slide( Vector2 linear_velocity, Vector2 floor_normal=Vector2( 0, 0 ), float slope_stop_min_velocity=5, int max_bounces=4, float floor_max_angle=0.785398 )
	# left_over_motion = move_and_slide( v_movement + Vector2(0, gravity), Vector2( 0, +-1 ), 5, 3, 0.785398)
	# bool stop_on_slope=false, int max_slides=4, float floor_max_angle=0.785398, bool infinite_inertia=true
	left_over_motion = move_and_slide( v_movement, Vector2(0,-1), false, 4, 0.785398, false)

	if get_slide_count():
		for i in range(0, get_slide_count()):
			var collision = get_slide_collision(i)
			if collision.collider.is_in_group("BALL"):
#				print("collided with ball")
				var ball = collision.collider
				ball.bounce(- collision.normal)
#			elif ! collision.collider is StaticBody2D:
#				print("collided with something else: ", collision.collider)
#			elif collision.collider is StaticBody2D:
##				print("collided with wall")
#				pass
			else:
#				print("collided with: ", collision.collider)
				pass

	b_up +=  gravity

	if(is_on_floor()):
#		print("is on floor")
		v_movement.y = 0
	if(is_on_wall()):
#		print("is on wall")
		v_movement.x = 0

	v_movement.x *= linear_damping

	#self.move_and_collide(v_movement + Vector2(0, gravity))

#				print("collision: ", collision.collider , " left_over_motion: ", left_over_motion)
				#collision.collider.apply_impulse(Vector2(0,0), left_over_motion * 0.01)
				# this is only necessary on godot < 3.1
				#collision.collider.apply_impulse(Vector2(0,0), collision.normal * -0.05)


				# get_node("../ball").apply_impulse(



func _input(event):

	if event.is_echo():
		return 0

	# Move right
	if Input.is_action_pressed("ui_right"):
		b_right = f_move;
	elif Input.is_action_just_released("ui_right"):
		b_right = 0

	if Input.is_action_pressed("ui_left"):
		b_left = -f_move
	elif Input.is_action_just_released("ui_left"):
		b_left = 0

	if Input.is_action_pressed("ui_up") && is_on_floor():
		b_up = -f_jump*2
	elif Input.is_action_just_released("ui_up") && is_on_floor():
		b_up = 0

	if Input.is_action_pressed("ui_down"):
		b_down = f_jump/2;
	elif Input.is_action_just_released("ui_down"):
		b_down = 0

#	if(move_forward + move_backward != 0):
#		v_movement.x = move_forward + move_backward
#	else:
#		v_movement.x = 0

#	if(move_up + move_down != 0):
#	v_movement.y += move_up + move_down
#	else:
#		v_movement.y = 0
