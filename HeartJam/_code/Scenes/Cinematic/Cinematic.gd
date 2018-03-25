extends CanvasLayer

var index = 0

var image_array = [
preload("res://_graphics/Cinematic/Cinematic_1_1.png"),
preload("res://_graphics/Cinematic/Cinematic_1_2.png"),
preload("res://_graphics/Cinematic/Cinematic_2.png"),
preload("res://_graphics/Cinematic/Cinematic_3_1.png"),
preload("res://_graphics/Cinematic/Cinematic_3_2.png"),
preload("res://_graphics/Cinematic/Cinematic_3_3.png"),
preload("res://_graphics/Cinematic/Cinematic_3_4.png"),
preload("res://_graphics/Cinematic/Cinematic_3_5.png"),
preload("res://_graphics/Cinematic/Cinematic_3_6.png")
]

var text_array = [
"When I was exploring in a forgotten place, I sensed some kind of power.",
"When I was exploring in a forgotten place, I sensed some kind of power.",
"It was a powerful relic. I was so foolish and couldn't resist the temptation to claim it.",
"'It's beautiful!' - I said - 'I wonder how much power does it contain...'",
"'It's beautiful!' - I said - 'I wonder how much power does it contain...'",
"'It's beautiful!' - I said - 'I wonder how much power does it contain...'",
"But after I picked it up, the whole place started to shake and a curse from the relic blinded me. Now i have to leave this place somehow..."
]

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	if Input.is_action_just_pressed("left_click") or Input.is_action_just_pressed("space"): next()
	

func next():
	if index < image_array.size()-1:
		if $Anim.is_playing(): $Anim.stop(true)
		
		match index:
			2:
				index = 5
				$Image/Text.text = text_array[3]
				$Anim.play("crystal")
				return
			5:
				index = image_array.size()-1
				$Image/Text.text = text_array[6]
				$Anim.play("curse")
				return
	index += 1
	if index >= image_array.size(): get_tree().change_scene("res://_code/Scenes/Menu/Menu.tscn")
	elif index != 3 and index != 6:
		$Image.texture = image_array[index]
		$Image/Text.text = text_array[index]
	
	
	
	


func _on_Skip_button_down():
	get_tree().change_scene("res://_code/Scenes/Menu/Menu.tscn")
