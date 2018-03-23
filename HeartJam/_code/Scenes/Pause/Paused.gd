extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	print(get_path())
	pass
		

func _on_BackToMenu_button_down():
	get_tree().paused = false
	get_tree().change_scene("res://_code/Scenes/Menu/Menu.tscn")
	queue_free()
