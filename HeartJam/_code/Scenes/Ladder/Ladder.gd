extends Area2D

var object = null

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	if Input.is_action_just_pressed("E") and object != null: object.global_position = $Laddertop.global_position


func _on_Ladder_body_entered(body):
	object = body


func _on_Ladder_body_exited(body):
	object = null
