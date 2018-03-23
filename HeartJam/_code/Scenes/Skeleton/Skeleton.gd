extends KinematicBody2D

var target = null
var hit_pos = Vector2()

var l_color = Color(0.9,0.16,0.04,1)

var do_draw = false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _physics_process(delta):
	
	update()
	
	if target != null: look()

func look():
	var ray = get_world_2d().direct_space_state.intersect_ray(position, target.position,[self],collision_mask)
	if ray:
		hit_pos = ray.position
		if ray.collider.name == "Player":
			#attack
			do_draw = true
			pass
		else:
			do_draw = false
	
func _draw():
	if do_draw: draw_line(Vector2(),hit_pos-position,l_color,1,true)


func _on_Sight_body_entered(body):
	if body.name == "Player": target = body


func _on_Sight_body_exited(body):
	target = null
