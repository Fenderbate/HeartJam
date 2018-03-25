extends KinematicBody2D

var s_stand = preload("res://_graphics/Player/Player_stand.png")
var s_jump = preload("res://_graphics/Player/Player_jump.png")



var dir = 0
var lastdir = 0
var spd = 200
var gravity = 200
var motion = Vector2()
var FLOOR_NORMAL = Vector2(0,-1)

var JUMP_HEIGHT = -300
var jumped = false
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

var maxhealth = float(10)
var health = float(10)
var max_mana = float(1000)
var mana = float(1000)

var can_change_text = true
var wallhit =[
"ouch...",
"uhh...",
"hit something again...",
"another wall..."

]

var enemyhit=[
"OUCH!",
"Something hit me!",
"What was that!?"
]

var manastage = [
false,#75%
false,#50%
false,#25%
false,#10%
false # 0%

]

func _ready():
	if(!visible):show()

func _physics_process(delta):
	
	magic_eyes()
	
	input()
	movement(delta)
	
	#if (Global.batears or Global.vibration or Global.magiceyes) and $ManaTimer.is_stopped(): $ManaTimer.start()
	
	update()
	

func _draw():
	for x in get_slide_count():
		draw_line(Vector2(),Vector2(100,100)*-get_slide_collision(x).normal,Color(1,1,1,1),2,false)
	
	
	#draw_texture(t,Vector2(0,-20))

func input():
	if Input.is_action_just_pressed("space"):
		if !$Anim.current_animation == "attack": $Anim.play("attack")
	dir = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	if dir != 0:
		$Sprite.scale.x = 2*dir
		lastdir = dir
	if Input.is_action_just_pressed("up") and is_on_floor():
		motion.y = JUMP_HEIGHT
		$Audio.stream = Global.step[rand_range(0,Global.step.size())]
		$Audio.play()
	
	#if dir != 0: $Sprite.scale.x = 2* dir
	
	if!is_on_floor() and $Anim.current_animation != "jump": $Anim.play("jump")
	elif dir != 0 and is_on_floor() and $Anim.current_animation != "move": $Anim.play("move")
	elif dir == 0 and is_on_floor() and $Anim.current_animation != "stand" and $Anim.current_animation !="attack":
		$Anim.play("stand")
	
	if Input.is_action_just_pressed("magic_eyes") and mana >= 10:
		$MEParticles.emitting = !$MEParticles.emitting
		Global.magiceyes = !Global.magiceyes
	if Input.is_action_just_pressed("bat_ears") and mana >= 2:
		$BEParticles.emitting = !$BEParticles.emitting
		Global.batears = !Global.batears
	if Input.is_action_just_pressed("vibration") and mana >= 5:
		$VParticles.emitting = !$VParticles.emitting
		Global.vibration = !Global.vibration
	

func movement(delta):
	var g = 0
	if motion.y <= 0: g = gravity*delta*2
	else: g = (gravity*2)*delta*2
	motion = Vector2(spd*dir,motion.y+g)
	motion = move_and_slide(motion,FLOOR_NORMAL)
	
	if is_on_floor() and jumped == true:
		jumped = false
		$Audio.stream = Global.step[rand_range(0,Global.step.size())]
		$Audio.play()
	elif !is_on_floor() and jumped == false:
		jumped = true
	
	for x in get_slide_count(): if get_slide_collision(x).normal.x != 0 and $Speech.text == "":
		randomize()
		if get_slide_collision(x).collider.name == "TileMap" and is_on_floor(): say(wallhit[rand_range(0,wallhit.size())],1)
		return

func magic_eyes():
	if Global.magiceyes == true and !$MagicEyes.visible:
		$Sight.hide()
		$MagicEyes.show()
	elif Global.magiceyes == false and $MagicEyes.visible:
		$Sight.show()
		$MagicEyes.hide()
	$MagicEyes.look_at(get_global_mouse_position())

func hurt(damage):
	randomize()
	$Hurt.play()
	health -= damage
	healthstatus()
	if(health <= 0):
		$Sprite.hide()
		get_parent().add_child(load("res://_code/Scenes/Game Over/Game_Over.tscn").instance())
		pass
	else: say(enemyhit[rand_range(0,enemyhit.size())],1)

func say(text, time, persistent = false):
	if persistent == true:
		can_change_text = false
		$Speech.text = text
		$SpeechTimer.wait_time = time
		$SpeechTimer.start()
	if can_change_text == true:
		$Speech.text = text
		$SpeechTimer.wait_time = time
		$SpeechTimer.start()

func _on_SpeechTimer_timeout():
	if can_change_text == false: can_change_text = true
	$Speech.text = ""

func playsound(filename):
	match filename:
		"step":
			if !$Audio.playing:
				$Audio.stream = Global.step[rand_range(0,Global.step.size())]
				$Audio.play()
			else:
				$Audio2.stream = Global.step[rand_range(0,Global.step.size())]
				$Audio2.play()
		"swing":
			if !$Audio.playing:
				$Audio.stream = Global.swing
				$Audio.play()
			else:
				$Audio2.stream = Global.swing
				$Audio2.play()

func attack(start):
	if start:
		match lastdir:
			1:$Weapon/Right.disabled = false
			-1:$Weapon/Left.disabled = false
	else:
		$Weapon/Right.disabled = true
		$Weapon/Left.disabled = true
	
	pass

func _on_ManaTimer_timeout():
	if Global.magiceyes: mana -= 10
	if Global.vibration: mana -= 5
	if Global.batears: mana -= 2
	
	if mana < 0: mana = 0
	
	
	print(mana)
	manastatus()

func manastatus():
	if float(mana / max_mana) <= 0.75 and manastage[0] == false:
		manastage[0] = true
		$UI/BlueEye.frame = 1
	if float(mana / max_mana) <= 0.5 and manastage[1] == false:
		say("I'm starting to get tired.",5)
		manastage[1] = true
		$UI/BlueEye.frame = 2
	if float(mana / max_mana) <= 0.25 and manastage[2] == false:
		say("Most of my strengh is gone... where's the exit?!",5)
		manastage[2] = true
		$UI/BlueEye.frame = 3
	if float(mana / max_mana) <= 0.1 and manastage[3] == false:
		say("I'm reaching my limit.",5)
		manastage[3] = true
	if float(mana / max_mana) <= 0 and manastage[4] == false:
		say("I ran out of strengh... Hopefully this place ran out of corridoors too...",5)
		manastage[4] = true
		$UI/BlueEye.frame = 4

func healthstatus():
	if float(health/maxhealth) <= 0.75: $UI/RedEye.frame = 1
	if float(health/maxhealth) <= 0.5: $UI/RedEye.frame = 2
	if float(health/maxhealth) <= 0.25: $UI/RedEye.frame = 3
	if float(health/maxhealth) <= 0: $UI/RedEye.frame = 4

func _on_Weapon_body_entered(body):
	$Weapon/Hit.play()
	body.hurt(1)
