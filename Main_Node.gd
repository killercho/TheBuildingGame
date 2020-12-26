extends Spatial

var mouse_sens = 0.03
var camera_anglev=0

var box_scene = load("res://Box.tscn")
var box_index = 0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	if Input.is_action_just_pressed("add_box"):
		var box_instance = box_scene.instance()
		box_instance.transform.origin.x = 0
		box_instance.transform.origin.y = 6
		box_instance.transform.origin.z = 0
		get_tree().get_root().call_deferred("add_child", box_instance)
	 
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
