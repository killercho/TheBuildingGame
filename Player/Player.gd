extends KinematicBody

var SPEED = 10
var ACCELERATION = 5
var MOUSE_SENS = 0.1
var GRAVITY = 1.5
var JUMP_POWER = 40

var velocity = Vector3()
var camera_x_rotation = 0

onready var head = $Head
onready var camera = $Head/Camera
onready var label = $Head/Camera/Label

func _input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(deg2rad(-event.relative.x * MOUSE_SENS))
		
		var x_delta = event.relative.y * MOUSE_SENS
		if camera_x_rotation + x_delta > -90 and camera_x_rotation + x_delta < 90:
			camera.rotate_x(deg2rad(-x_delta))
			camera_x_rotation += x_delta

func _physics_process(delta):
	var walk_up = Input.is_action_pressed("walk_up")
	var walk_down = Input.is_action_pressed("walk_down")
	var walk_right = Input.is_action_pressed("walk_right")
	var walk_left = Input.is_action_pressed("walk_left")
	var walk_forward = Input.is_action_pressed("walk_forward")
	var walk_back = Input.is_action_pressed("walk_back")
	var jump = Input.is_action_pressed("jump")
	var grab = Input.is_action_just_pressed("use")
	var release_grabbed = Input.is_action_just_released("use")
	
	var direction = Vector3()
	var head_basis = head.get_global_transform().basis
	
	if walk_forward:
		direction -= head_basis.z
	elif walk_back:
		direction += head_basis.z
		
	if walk_left:
		direction -= head_basis.x
	elif walk_right:
		direction += head_basis.x
		
	if walk_up:
		direction += head_basis.y
	elif walk_down:
		direction -= head_basis.y
		
	direction = direction.normalized()
	
	velocity = velocity.linear_interpolate(direction * SPEED, ACCELERATION * delta)
	velocity.y -= GRAVITY
	
	if jump and is_on_floor():
		velocity.y += JUMP_POWER
	
	velocity = move_and_slide(velocity, Vector3.UP)
	
	if grab:
		print("I grabbed a box!")
	if release_grabbed:
		print("I released the item!")
