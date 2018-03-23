extends Control

var startscene = load("res://_code/Scenes/_TESTING/Testing_Chamber.tscn")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _on_Start_button_down():
	get_tree().change_scene(startscene)
	print("asd")

func _on_Options_button_down():
	if(!$Options_Panel.visible):$Options_Panel.show()
	else: $Options_Panel.hide()

func _on_Exit_button_down():
	$Exit_Game.show()

func _on_Resolution_item_selected(ID):
	var res = $Options_Panel/Resolution.get_item_text(ID).split("x")
	OS.window_size = Vector2(res[0],res[1])
	OS.center_window()

func _on_VSync_toggled(button_pressed):
	OS.vsync_enabled = button_pressed

func _on_MasterSound_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),value)

func _on_Music_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),value)

func _on_Sound_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound"),value)

func _on_Yes_button_down():
	get_tree().quit()

func _on_No_button_down():
	$Exit_Game.hide()
