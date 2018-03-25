extends Control

var vibimg = preload("res://_code/Scenes/Player/VibrationImage.tscn")
var bs = preload("res://_code/Scenes/Player/BatSpot.tscn")
var hit = preload("res://_sounds/Combat/staff_hit.wav")

var step = [
preload("res://_sounds/Step/step_1.wav"),
preload("res://_sounds/Step/step_2.wav"),
preload("res://_sounds/Step/step_3.wav"),
preload("res://_sounds/Step/step_4.wav"),
preload("res://_sounds/Step/step_5.wav"),
preload("res://_sounds/Step/step_6.wav")
]



var bone = [
preload("res://_sounds/Bone/bonerattle_1.wav"),
preload("res://_sounds/Bone/bonerattle_2.wav"),
preload("res://_sounds/Bone/bonerattle_3.wav")
]

var ghost = [

]

var swing = preload("res://_sounds/Combat/swing_wav.wav")

var magiceyes = false
var batears = false
var vibration = false

var spawn_bat_bubble = false

func _ready():
	pass

func reload():
	magiceyes = false
	batears = false
	vibration = false

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel") and !get_tree().root.has_node("Menu"):
		if !get_tree().paused:
			get_tree().paused = true
			get_tree().root.add_child(load("res://_code/Scenes/Pause/Paused.tscn").instance())
		else:
			get_tree().paused = false
			get_tree().root.get_node("Paused").queue_free()
	
	#if(batears): bat_ears()
	#if(vibration): vibration(get_tree().root.get_node("World/ASD/ASD"))

func bat_ears(pos):
	#if(Input.is_action_just_pressed("left_click")):
	var b = bs.instance()
	randomize()
	b.position = pos + Vector2(rand_range(-50,50),rand_range(-50,50))
	if spawn_bat_bubble:
		get_tree().root.add_child(b)
		spawn_bat_bubble = false

func vibration(target):
	var v = vibimg.instance()
	v.scale = target.scale
	v.texture = target.texture
	v.hframes = target.hframes
	v.vframes = target.vframes
	v.frame = target.frame
	v.position = target.get_parent().position
	v.rotation = target.get_parent().rotation
	get_tree().root.add_child(v)

func _on_BatEarsTimer_timeout():
	spawn_bat_bubble = true
