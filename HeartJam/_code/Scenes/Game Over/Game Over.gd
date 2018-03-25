extends CanvasLayer

func _ready():
	get_tree().paused = true

func _on_Retry_button_down():
	Global.reload()
	get_tree().paused = false
	get_tree().change_scene("res://_code/Scenes/_TESTING/Testing_Chamber.tscn")


func _on_Exit_button_down():
	get_tree().paused = false
	get_tree().change_scene("res://_code/Scenes/Menu/Menu.tscn")
