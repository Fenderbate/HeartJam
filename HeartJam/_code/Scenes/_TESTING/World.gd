extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	
	
	if Global.batears:
		for g in get_tree().get_nodes_in_group("Ghost"):
			Global.bat_ears(g.position)
