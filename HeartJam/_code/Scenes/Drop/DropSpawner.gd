extends Node2D

var drop = preload("res://_code/Scenes/Drop/Drop.tscn")


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Timer_timeout():
	var d = drop.instance()
	randomize()
	d.position = Vector2(position.x + rand_range($Left.position.x,$Right.position.x),position.y)
	get_parent().add_child(d)
