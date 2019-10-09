extends RigidBody2D
# extends KinematicBody2D

var gravity = 1

func _ready():
	add_to_group("BALL")

func _physics_process(delta):
	# move_and_slide(Vector2(0, gravity))
	pass

func bounce(direction):
	linear_velocity += direction.normalized() * 192.4