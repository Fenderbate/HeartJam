extends CanvasLayer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	if Input.is_action_just_pressed("left_click") or Input.is_action_just_pressed("space"):
		if $Ending.visible: $Ending.hide()
		else: get_tree().change_scene("res://_code/Scenes/Menu/Menu.tscn")
