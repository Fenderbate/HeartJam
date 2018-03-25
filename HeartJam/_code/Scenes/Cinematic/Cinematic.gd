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
preload("res://_graphics/Cinematic/Cinematic_1_text.png"),
preload("res://_graphics/Cinematic/Cinematic_1_text.png"),
preload("res://_graphics/Cinematic/Cinematic_2_text.png"),
preload("res://_graphics/Cinematic/Cinematic_3_1_2_3_text.png"),
preload("res://_graphics/Cinematic/Cinematic_3_1_2_3_text.png"),
preload("res://_graphics/Cinematic/Cinematic_3_1_2_3_text.png"),
preload("res://_graphics/Cinematic/Cinematic_3_4_5_6_text.png"),
preload("res://_graphics/Cinematic/Cinematic_3_4_5_6_text.png"),
preload("res://_graphics/Cinematic/Cinematic_3_4_5_6_text.png")
]

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	if Input.is_action_just_pressed("left_click"): next()
	

func next():
	if index < image_array.size()-1:
		if $Anim.is_playing(): $Anim.stop(true)
		
		match index:
			2:
				index = 5
				$Anim.play("crystal")
				return
			5:
				index = image_array.size()-1
				$Anim.play("curse")
				return
		index += 1
		if index != 3 and index != 6:
			$Image.texture = image_array[index]
			$Image/Text.texture = text_array[index]
		
	
