extends Node2D

var batears = false
var vibration = false

func _ready():
	pass
	
func _draw():
	draw_line(Vector2(0,0),Vector2(10,10),Color(1,1,1,1),1)

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if !get_tree().paused:
			get_tree().paused = true
			get_tree().root.add_child(load("res://_code/Scenes/Pause/Paused.tscn").instance())
		else:
			get_tree().paused = false
			get_tree().root.get_node("Paused").queue_free()
