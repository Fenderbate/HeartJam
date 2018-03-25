extends CanvasLayer

var startscene = "res://_code/Scenes/_TESTING/Testing_Chamber.tscn"

var htppage = 0

func _ready():
	if(get_parent().name != "root"): $Music.stop()
	$Options_Panel/MasterSound.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	$Options_Panel/Sound.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Sound"))
	$Options_Panel/Music.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))
	#AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),value)
	
func _process(delta):
	pass
	
	
func htppages():
	for p in get_tree().get_nodes_in_group("Page"):
		if p.name != str("Page ",htppage):p.hide()
		else: p.show()


func _on_Start_button_down():
	get_tree().change_scene(startscene)

func _on_Options_button_down():
	$Exit_Game.hide()
	if(!$Options_Panel.visible):
		$HTP_Panel.hide()
		htppage = 0
		$Options_Panel.show()
	else: $Options_Panel.hide()

func _on_HowToPlay_button_down():
	$Exit_Game.hide()
	if(!$HTP_Panel.visible):
		$Options_Panel.hide()
		$HTP_Panel.show()
		htppages()
	else:
		$HTP_Panel.hide()
		htppage = 0

func _on_Exit_button_down():
	if !$Exit_Game.visible: $Exit_Game.show()
	else: $Exit_Game.hide()

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





func _on_Prev_button_down():
	if htppage > 0: htppage-=1
	htppages()


func _on_Next_button_down():
	if htppage < 3: htppage+=1
	
	htppages()
