extends KinematicBody2D

const GRAVITY = 1500.0
var WALK_SPEED = 60
var rayCastLeft = null
var rayCastRight = null
var velocity = Vector2()
var playing = false
var animPlayer = null
var has_collided = false
func _ready():

	rayCastLeft = get_node("RayCastLeft")
	rayCastRight = get_node("RayCastRight")
	
	animPlayer = get_node("anim")
	animPlayer.play("run")
	set_fixed_process(true)

func _fixed_process(delta):
	velocity.y += delta * GRAVITY
	checkLeftRightBound()
	#print(WALK_SPEED)

	velocity.x = WALK_SPEED
	#print(WALK_SPEED)
	

	var motion = velocity * delta
	motion = move(motion)
	
	if is_colliding():
		var n = get_collision_normal()
		motion = n.slide(motion)
		velocity = n.slide(velocity)
		move(motion)

func checkLeftRightBound():

	if rayCastLeft.is_colliding() and not rayCastRight.is_colliding() and not rayCastLeft.get_collider().get_name()=="bullet":
	
		if playing:
			get_node("Sprite").set_flip_h(false)
		if rayCastLeft.get_collider().get_name() == "player" :
			WALK_SPEED = 230
		else:
			WALK_SPEED = 60
		#print("left colliding")
		#print(rayCastLeft.get_collider().get_name())
		WALK_SPEED = abs(WALK_SPEED)
		

	elif rayCastRight.is_colliding() and not rayCastLeft.is_colliding() and rayCastRight.get_collider().get_name()!="bullet" :
		playing=true
		get_node("Sprite").set_flip_h(true)
		if rayCastRight.get_collider().get_name() == "player":
			WALK_SPEED = 230
		else:
			WALK_SPEED = 60
		#print("right colliding")
		#print(get_name())
		WALK_SPEED = -WALK_SPEED
	#if (rayCastRight.get_collider().get_name() || rayCastLeft.get_collider().get_name())

