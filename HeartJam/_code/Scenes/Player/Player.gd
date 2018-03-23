extends KinematicBody2D

var dir = 0
var spd = 200
var gravity = 200
var motion = Vector2()

var JUMP_HEIGHT = -200

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _physics_process(delta):
	
	$MagicEyes.position = get_local_mouse_position()
	
	input()
	movement(delta)


func input():
	#if Input.is_action_just_pressed("ui_cancel"): 
	
	dir = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	if Input.is_action_just_pressed("up") and is_on_floor(): motion.y = JUMP_HEIGHT

func movement(delta):
	motion = Vector2(spd*dir,motion.y+(gravity*delta))
	motion = move_and_slide(motion,Vector2(0,-1))