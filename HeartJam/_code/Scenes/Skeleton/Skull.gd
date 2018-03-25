extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	apply_impulse(Vector2(),Vector2(rand_range(-100,100),0))

func _process(delta):
	if(Global.batears): Global.bat_ears(position)

func _on_Clear_timeout():
	queue_free()


func _on_Skull_body_entered(body):
	if Global.vibration: Global.vibration($Sprite)
