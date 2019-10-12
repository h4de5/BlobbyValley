extends RigidBody2D
# extends KinematicBody2D

var gravity = 1

var start_position = Vector2()

func _ready():
	start_position = position;
	add_to_group("BALL")

func _physics_process(delta):
	if get_colliding_bodies():
		var collisions = get_colliding_bodies()
		for i in range(0, collisions.size()):
			if collisions[i].is_in_group("FLOOR"):
				new_game()
			else:
				print("something elese: ", collisions[i])

func new_game():
	print("New game")
	position = start_position
	linear_velocity = Vector2(0,0)
	angular_velocity = 0



func bounce(direction):
	linear_velocity += direction.normalized() * 192.4
