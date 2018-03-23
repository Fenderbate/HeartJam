extends KinematicBody2D

var dir = 0
var spd = 200
var gravity = 200
var motion = Vector2()
var FLOOR_NORMAL = Vector2(0,-1)

var JUMP_HEIGHT = -200

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _physics_process(delta):
	
	input()
	movement(delta)
	
	
	
	
	update()
	

func _draw():
	for x in get_slide_count():
		draw_line(Vector2(),Vector2(100,100)*-get_slide_collision(x).normal,Color(1,1,1,1),2,false)
	
	
	#draw_texture(t,Vector2(0,-20))

func input():
	dir = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	if Input.is_action_just_pressed("up") and is_on_floor(): motion.y = JUMP_HEIGHT
	
	
	if Input.is_action_pressed("magic_eyes"): magic_eyes()
	elif Input.is_action_pressed("bat_ears"): Global.batears = true
	elif Input.is_action_pressed("vibration"): vibration(get_parent().get_node("ASD/ASD"))
	else:
		$MagicEyes.hide()
		Global.batears = false
		#turn off vibration
	
	

func movement(delta):
	motion = Vector2(spd*dir,motion.y+(gravity*delta))
	motion = move_and_slide(motion,FLOOR_NORMAL)

func magic_eyes():
	if(!$MagicEyes.visible): $MagicEyes.show()
	$MagicEyes.position = get_local_mouse_position()

func bat_ears():
	if(Input.is_action_just_pressed("left_click")):
		var b = load("res://_code/Scenes/Player/BatSpot.tscn").instance()
		b.position = get_global_mouse_position()
		get_parent().add_child(b)

func vibration(target):
	if(Input.is_action_just_pressed("left_click")):
		var v = load("res://_code/Scenes/Player/VibrationImage.tscn").instance()
		v.scale = target.scale
		v.texture = target.texture
		v.hframes = target.hframes
		v.vframes = target.vframes
		v.frame = target.frame
		v.position = target.get_parent().position
		get_parent().add_child(v)