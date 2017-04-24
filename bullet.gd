extends RigidBody2D
var disabled = false

func disable():
	if disabled:
		return
	get_node("anim").play("shutdown")
	disabled = true
	#queue_free()
	#remove_and_skip()
	
func _ready():
	set_process(true)
	get_node("Timer").start()
	
func _process(delta):
	if(get_colliding_bodies().size()>0):
		if get_colliding_bodies()[0].is_in_group("enemies"):
			#print(get_colliding_bodies()[0].get_name())
			disabled=true
			queue_free()
