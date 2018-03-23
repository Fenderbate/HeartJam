extends Control

var batears = false
var vibration = false

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if !get_tree().paused:
			get_tree().paused = true
			get_tree().root.add_child(load("res://_code/Scenes/Pause/Paused.tscn").instance())
		else:
			get_tree().paused = false
			get_tree().root.get_node("Paused").queue_free()
	
	if(batears): bat_ears()
	if(vibration): vibration(get_tree().root.get_node("World/ASD/ASD"))

func bat_ears():
	if(Input.is_action_just_pressed("left_click")):
		var b = load("res://_code/Scenes/Player/BatSpot.tscn").instance()
		b.position = get_global_mouse_position()
		get_tree().root.add_child(b)

func vibration(target):
	if(Input.is_action_just_pressed("left_click")):
		var v = load("res://_code/Scenes/Player/VibrationImage.tscn").instance()
		v.scale = target.scale
		v.texture = target.texture
		v.hframes = target.hframes
		v.vframes = target.vframes
		v.frame = target.frame
		v.position = target.get_parent().position
		get_tree().root.add_child(v)