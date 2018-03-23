extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if !get_tree().paused:
			get_tree().paused = true
			get_tree().root.add_child(load("res://_code/Scenes/Pause/Paused.tscn").instance())
		else:
			get_tree().paused = false
			get_tree().root.get_node("Paused").queue_free()
