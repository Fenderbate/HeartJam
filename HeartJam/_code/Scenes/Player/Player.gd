extends KinematicBody2D

var s_stand = preload("res://_graphics/Player/Player_stand.png")
var s_jump = preload("res://_graphics/Player/Player_jump.png")

var dir = 0
var spd = 200
var gravity = 200
var motion = Vector2()
var FLOOR_NORMAL = Vector2(0,-1)

var JUMP_HEIGHT = -200
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

var magiceyes = false

var mana = 1000

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _physics_process(delta):
	
	
	
	input()
	movement(delta)
	
	if (Global.batears or Global.vibration or magiceyes) and $ManaTimer.is_stopped(): $ManaTimer.start()
	
	update()
	

func _draw():
	for x in get_slide_count():
		draw_line(Vector2(),Vector2(100,100)*-get_slide_collision(x).normal,Color(1,1,1,1),2,false)
	
	
	#draw_texture(t,Vector2(0,-20))

func input():
	dir = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	if Input.is_action_just_pressed("up") and is_on_floor(): motion.y = JUMP_HEIGHT
	
	#if dir != 0: $Sprite.scale.x = 2* dir
	
	if!is_on_floor() and !$Anim.current_animation.begins_with("jump"):
		match dir:
			-1: $Anim.play("jump_left")
			1: $Anim.play("jump_right")
	elif dir == 0 and is_on_floor() and !$Anim.current_animation.begins_with("stand"):
		$Anim.play("stand")
	elif dir != 0 and is_on_floor() and !$Anim.current_animation.begins_with("move"):
		match dir:
			-1: $Anim.play("move_left")
			1: $Anim.play("move_right")
	
	if Input.is_action_pressed("magic_eyes"): magic_eyes()
	elif Input.is_action_pressed("bat_ears"): Global.batears = true
	elif Input.is_action_pressed("vibration"): Global.vibration = true#vibration(get_parent().get_node("ASD/ASD"))
	else:
		$MagicEyes.hide()
		magiceyes = false
		Global.batears = false
		Global.vibration = false
	
	

func movement(delta):
	motion = Vector2(spd*dir,motion.y+(gravity*delta))
	motion = move_and_slide(motion,FLOOR_NORMAL)

func magic_eyes():
	if(!$MagicEyes.visible):
		$MagicEyes.show()
		magiceyes = true
	$MagicEyes.position = get_local_mouse_position()


func _on_ManaTimer_timeout():
	if magiceyes: mana -= 10
	elif Global.vibration: mana -= 5
	elif Global.batears: mana -= 2
