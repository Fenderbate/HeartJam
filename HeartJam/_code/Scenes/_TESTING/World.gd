extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass



func _on_End_body_entered(body):
	get_tree().change_scene("res://_code/Scenes/End/WP.tscn")
