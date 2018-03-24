extends Area2D

export var persistent = false
export var persistent_text = true
export var text_time = 5
export var text_to_say = ""

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Speechtrigger_body_entered(body):
	body.say(text_to_say, text_time, persistent_text)
	if persistent == false: queue_free()
