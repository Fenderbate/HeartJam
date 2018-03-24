extends KinematicBody2D

var skull = preload("res://_code/Scenes/Skeleton/Skull.tscn")

var target = null
var hit_pos = Vector2()

var l_color = Color(0.9,0.16,0.04,1)

var do_draw = false

var dir = 0
var lastdir = 0
var spd = 100
var moving = false

var dmg = 1
var health = 1

func _ready():
	$Anim.play("stand")

func _physics_process(delta):
	
	
	
	update()
	
	if target != null: look()
	else:
		moving = false
		if $Anim.current_animation != "stand":
			$Anim.play("stand")

func look():
	var ray = get_world_2d().direct_space_state.intersect_ray(position, target.position,[self],3)
	if ray:
		moving = false
		hit_pos = ray.position
		if ray.collider.name == "Player":
			moving = true
			attack()
			#do_draw = true
			pass
		else:
			moving = false
			pass#do_draw = false

func attack():
	
	if -(position-hit_pos).normalized().x > 0: dir = 1
	else: dir = -1
	
	if position.distance_to(hit_pos) > 20:
		move_and_slide(Vector2(spd*dir,0),Vector2(0,1))
		if !$Anim.current_animation.begins_with("move"):
			match dir:
				1: $Anim.play("move_right")
				-1: $Anim.play("move_left")
		else:
			if(lastdir != dir):
				lastdir = dir
				match dir:
					1: $Anim.play("move_right")
					-1: $Anim.play("move_left")
	else:
		if $Anim.current_animation != "attack" or !$Anim.is_playing(): $Anim.play("attack")
		#if $Attack.is_stopped(): $Attack.start()
	

func _draw():
	pass#if do_draw: draw_line(Vector2(),hit_pos-position,l_color,1,true)

func step():
	if moving:
		$Sound.stream = Global.step[rand_range(0,Global.step.size())]
		$Sound.play()
	if(Global.vibration): Global.vibration($Sprite)
	if(Global.batears): Global.bat_ears(position)

func _on_Sight_body_entered(body):
	target = body


func _on_Sight_body_exited(body):
	target = null

func hit():
	target.hurt(dmg)
	
func hurt(dmg):
	health -= dmg
	if health <= 0:
		var s = skull.instance()
		s.position = $Head.global_position
		get_parent().add_child(s)
		queue_free()


func _on_Attack_timeout():
	$Anim.play("attack")
	
