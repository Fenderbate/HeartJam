extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	apply_impulse(Vector2(),Vector2(rand_range(-100,100),0))

func _on_Clear_timeout():
	queue_free()
