extends StaticBody2D

var player = false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	if Input.is_action_just_pressed("down") and player == true: queue_free() 


func _on_Check_body_entered(body):
	player = true


func _on_Check_body_exited(body):
	player = false
