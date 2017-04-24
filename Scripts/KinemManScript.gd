extends KinematicBody2D


const GRAVITY = 2000.0
const MIN_WALK_SPEED = 50
const JUMP_FORCE = 770
const MAX_WALK_SPEED = 270
const MAX_ANIM_SPEED = 2.4

var anim_speed = 0.0
var WALK_SPEED = 230


var isManSiting = 0
var isOnFloor = 0
var isInAir = false
var isLeftLim = 0
var isRightLim = 0
var cur_pos
var velocity = Vector2()
var animPlayer
var is_enemie_found = false
var walking = false
var direction = 0
var rayCastDown
var bullet = preload("res://bullet.tscn")
var timer = Timer.new()
var shooting = false
var idle = false
const SLIDE_STOP_VELOCITY = 1 # One pixel per second
const SLIDE_STOP_MIN_TRAVEL = 1 # One pixel

func _ready():
	
	rayCastDown = get_node("rayCast")
	rayCastDown.add_exception(self)
	timer.connect("timeout", self, "set_enemie_not_found")
	timer.set_wait_time(1)
	add_child(timer)
	set_fixed_process(true)
	animPlayer = get_node("man/AnimationPlayer")
	WALK_SPEED = MIN_WALK_SPEED
	
func set_enemie_not_found():
	is_enemie_found = false

func set_idle_action():
	animPlayer.play("idle")
	
func _fixed_process(delta):
	
	var jump = Input.is_action_pressed("ui_up")
	var walkRight = Input.is_action_pressed("ui_right")
	var walkLeft = Input.is_action_pressed("ui_left")
	var shoot = Input.is_action_pressed("ui_select")
	isManSiting = self.get_node("man/AnimationPlayer").get_current_animation()
	velocity.y += delta * GRAVITY
	
	
	#### walking 
	
	if walkLeft:
		#print("left")
		direction = -1
		velocity.x -= 15
		if velocity.x  < -MAX_WALK_SPEED:
			velocity.x = -MAX_WALK_SPEED
			
	if walkRight:
		direction = 1
		velocity.x += 15
		if  velocity.x  > MAX_WALK_SPEED:
			velocity.x = MAX_WALK_SPEED
			
	if walkLeft or walkRight:idle=false
	
	if not walkLeft and not walkRight and checkFloor():
		direction = 0
	
		if velocity.x < 0:
			velocity.x += abs(velocity.x)/5
		elif velocity.x > 0:
			velocity.x -= abs(velocity.x)/5	
		else:
			velocity.x = 0
			
	elif not walkLeft and not walkRight and not checkFloor():
		if velocity.x < 0:
			velocity.x += abs(velocity.x)/30
			
		elif velocity.x > 0:
			velocity.x -= abs(velocity.x)/30

		else:
			#animPlayer.play("idle")
			velocity.x = 0
			
	if walkLeft and walkRight:
		if direction < 0:
			direction = 1
		elif direction > 0:
			direction = -1
			
	#### end walking
	#print(velocity.x)

	
	#####    shooting 
	if shoot and not shooting:
		var ss
		var bi = bullet.instance()
		if (direction<0):
			ss = -1.0
			#bi.set_angular_velocity(-2)
			bi.get_node("Sprite").set_flip_h(false)
		else:
			#bi.set_angular_velocity(2)
			bi.get_node("Sprite").set_flip_h(true)
			ss = 1.0
			
		var pos = get_pos() + get_node("bullet_shoot").get_pos()*Vector2(ss, 1)
		bi.set_pos(pos)
		get_parent().add_child(bi)
		bi.add_collision_exception_with(self)
		
		bi.set_linear_velocity(Vector2(220.0*ss, 0))
	
	shooting = shoot
	
	#### end shooting
	
	#### jumping
	if (jump || !jump) && !checkFloor() && walking:
		walking=false
		if walkRight :
			animPlayer.play("JumpRight")
		elif walkLeft:
			animPlayer.play("JumpLeft")
			
	elif (jump || !jump) && checkFloor() && !walking:
		walking = true
		if walkRight:
			animPlayer.play("Runing")
		elif walkLeft:
			animPlayer.play("RuningLeft")
			
	var motion = velocity * delta
	motion = move(motion)
	
	if (is_colliding()):
		checkEnemey()
		
		
			
			
		if !jump:
			isOnFloor = 1

		if isManSiting == "sitting":
			if abs(velocity.x) == 0:
				velocity.x = 0
		#else:
			#WALK_SPEED = MIN_WALK_SPEED
			
		var n = get_collision_normal()
		#print(velocity.x)
		if  not jump and abs(velocity.x) < SLIDE_STOP_VELOCITY  and get_travel().length() < SLIDE_STOP_MIN_TRAVEL and get_collider_velocity() == Vector2() :
			revert_motion()
			velocity.y = 0.0
			
		else:
			motion = n.slide(motion)
			velocity = n.slide(velocity)
			
			if isOnFloor:
				if jump:
					velocity.y -= JUMP_FORCE
					isOnFloor = 0
					
			if WALK_SPEED>0:
				move(motion)
		
		
func checkFloor():
	if rayCastDown.is_colliding():
		#print("Hit the floor")
		return true
	else:
		#print("In the air")
		return false
	

func checkEnemey():
	if not is_enemie_found:
		if get_collider().is_in_group("enemies"): 
			is_enemie_found =  true
			print("ENEMIE IS FOUND")
#			total_coins_in_level = get_parent().get_node("Coins").get_children().size()
#
#			for Node in get_parent().get_node("Coins").get_children():
#			
#				if not Node.get_node("Coin").is_visible():
#					coins_in_level_rest+=1
#				elif not Node.get_node("Coin").is_visible():
#					coins_in_level_collected += 1
#		
#			if coins_in_level_rest == total_coins_in_level:
#				print("Congratulations you collected all coins")
#			else:
#				print("Collect rest % coins", coins_in_level_rest)
			timer.start()
			
