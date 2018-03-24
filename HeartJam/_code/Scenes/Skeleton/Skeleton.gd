extends KinematicBody2D

var target = null
var hit_pos = Vector2()

var l_color = Color(0.9,0.16,0.04,1)

var do_draw = false

var dir = 0
var spd = 200

func _ready():
	$Anim.play("stand")

func _physics_process(delta):
	
	
	
	update()
	
	if target != null: look()

func look():
	var ray = get_world_2d().direct_space_state.intersect_ray(position, target.position,[self],3)
	if ray:
		hit_pos = ray.position
		if ray.collider.name == "Player":
			attack()
			#do_draw = true
			pass
		else:
			pass#do_draw = false

func attack():
	
	if -(position-hit_pos).normalized().x > 0: dir = 1
	else: dir = -1
	
	if position.distance_to(hit_pos) > 20: move_and_slide(Vector2(spd*dir,0),Vector2(0,1))
	

func _draw():
	pass#if do_draw: draw_line(Vector2(),hit_pos-position,l_color,1,true)

func step():
	if(Global.vibration): Global.vibration($Sprite)
	if(Global.batears): Global.bat_ears(position)

func _on_Sight_body_entered(body):
	target = body


func _on_Sight_body_exited(body):
	target = null
