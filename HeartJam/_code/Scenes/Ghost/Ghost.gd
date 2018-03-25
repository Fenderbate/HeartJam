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
var gravity = 200
var motion = Vector2()

var dmg = 1
var health = 3

func _ready():
	pass#$Anim.play("stand")

func _physics_process(delta):
	
	motion.y += gravity*delta*2
	motion = move_and_slide(motion,Vector2(0,1))
	
	
	update()
	
	if target != null: look()
	else:
		moving = false
		motion.x = 0
		#if $Anim.current_animation != "stand":
		#	$Anim.play("stand")

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
			motion.x = 0
			pass#do_draw = false

func attack():
	
	if -(position-hit_pos).normalized().x > 0: dir = 1
	else: dir = -1
	
	if position.distance_to(hit_pos) > 20:
		motion.x = spd*dir
		if(lastdir != dir): lastdir = dir
	else:
		motion.x = 0
		if $Attack.is_stopped(): 
			hit()
			$Attack.start()
		#if $Anim.current_animation != "attack" or !$Anim.is_playing(): $Anim.play("attack")
		#if $Attack.is_stopped(): $Attack.start()
	

func _draw():
	pass#if do_draw: draw_line(Vector2(),hit_pos-position,l_color,1,true)

func step():
	if moving:
		$Sound.stream = Global.ghost[rand_range(0,Global.bone.size())]
		$Sound.play()
	if Global.vibration: Global.vibration($Sprite)

func _on_Sight_body_entered(body):
	target = body

func _on_Sight_body_exited(body):
	target = null

func hit():
	if(Global.vibration): Global.vibration($Sprite)
	target.hurt(dmg)
	
func hurt(dmg):
	if !$Sprite.visible: $Sprite.show()
	#if $Anim.current_animation == "attack": $Anim.stop(true)
	health -= dmg
	if health <= 0:
		#ded animation
		queue_free()


func _on_Attack_timeout():
	pass#$Anim.play("attack")
	
	
