extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var bat_ears_child = null

func _ready():
	apply_impulse(Vector2(),Vector2(rand_range(-100,100),0))

func _process(delta):
	if Global.batears: bat_ears(position)

func _on_Clear_timeout():
	queue_free()

func bat_ears(pos):
	#if(Input.is_action_just_pressed("left_click")):
	if bat_ears_child == null:
		bat_ears_child = Global.bs.instance()
		randomize()
		bat_ears_child.global_position = pos + Vector2(rand_range(-50,50),rand_range(-50,50))
		get_tree().root.add_child(bat_ears_child)

func _on_Skull_body_entered(body):
	if Global.vibration: Global.vibration($Sprite)


func _on_BETimer_timeout():
	bat_ears_child = null
