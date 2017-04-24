extends AnimatedSprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var cur_pos = self.get_pos()

var idle_action = 0
var timer
var runing = false
var can_run = true
var direction = 0
func _ready():
	timer = Timer.new()
	set_process_input(true)
	#set_process(true)
	print("hello")

	# Called every time the node is added to the scene.
	# Initialization here
	#pass

func _input(event):

	var is_left_pressed =  event.is_action_pressed("ui_left")
	var is_right_pressed =  event.is_action_pressed("ui_right")
	var is_up_pressed  = event.is_action_pressed("ui_up")
	var is_down_pressed = event.is_action_pressed("ui_down")
	
	var is_left_released = event.is_action_released("ui_left")
	var is_right_released = event.is_action_released("ui_right")
	var is_down_released =  event.is_action_released("ui_down")
	var is_up_released

	if not Input.is_action_pressed("ui_left") && not Input.is_action_pressed("ui_right") && not Input.is_action_pressed("ui_down"):
		direction = 0
		set_idle_action()
		runing=false
	

	if is_down_pressed:
		print(str("Sit down"))
		cur_pos.y += 6
		self.set_pos(cur_pos)
		self.get_node("AnimationPlayer").play("sitting")
		
	if is_down_released:
		cur_pos.y -= 6
		self.set_pos(cur_pos)
		self.get_node("AnimationPlayer").play("idle")
		
	
		
#	if get_parent().is_colliding():
		
#		if Input.is_action_pressed("ui_right") :
#			get_node("AnimationPlayer").play("Runing")
#		if Input.is_action_pressed("ui_left") :
#			get_node("AnimationPlayer").play("RuningLeft")
#	else :
#		if Input.is_action_pressed("ui_right"):
#			get_node("AnimationPlayer").play("JumpRight")
#		
	if is_right_pressed :
			runing=true
			get_node("AnimationPlayer").play("Runing")
			direction = 1
	elif is_left_pressed :
			direction = -1
			runing=true
			get_node("AnimationPlayer").play("RuningLeft")
	
	
		
	
func set_idle_action():
	get_node("AnimationPlayer").play("idle")
	
	
func jump():
	print("Jump")
	self.get_node("AnimationPlayer").play("jumping")
	#cur_pos.y -= 50
	#self.set_pos(cur_pos)
	
func _process(delta):
	
	var is_left_pressed =  Input.is_action_pressed("ui_left")
	var is_right_pressed =  Input.is_action_pressed("ui_right")
	var is_up_pressed 
	var is_down_pressed = Input.is_action_pressed("ui_down")
	
#	if(Input.is_action_pressed("ui_right")):
#		cur_pos.x += 300 * delta
#		print(str("Move right"))
#		if(cur_pos.x > self.get_viewport_rect().size.width + self.get_item_rect().size.width/2):
#			cur_pos.x = -self.get_item_rect().size.width/2
#		self.set_pos(cur_pos)
#	elif(Input.is_action_pressed("ui_left")):
#		cur_pos.x -= 300 * delta
#		print(str("Move left"))
#		if(cur_pos.x < -self.get_item_rect().size.width/2):
#			cur_pos.x = self.get_viewport_rect().size.width+get_item_rect().size.width/2
#		self.set_pos(cur_pos)
#
#		cur_pos.y -= 300 * delta
#		if(cur_pos.y < -self.get_item_rect().size.height/2):
#			cur_pos.y = self.get_viewport_rect().size.height+get_item_rect().size.height/2
#		self.set_pos(cur_pos)
		#self.jump(delta)
#	elif(Input.is_action_pressed("ui_down")):
#		cur_pos.y += 300 * delta
#		if(cur_pos.y > self.get_viewport_rect().size.height + self.get_item_rect().size.height/2):
#			cur_pos.y = -get_item_rect().size.height/2
#		self.set_pos(cur_pos)
	
#	if Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_right") and runing and can_run:
#		if direction > 0:
#			can_run=false
#			get_node("AnimationPlayer").play("Runing")
#		elif direction < 0:
#			can_run = false
#			get_node("AnimationPlayer").play("RuningLeft")
	
	if is_right_pressed  and runing and can_run:
		can_run = false
		print("play run right")
		get_node("AnimationPlayer").play("Runing")
	elif is_left_pressed && runing && can_run:
		can_run = false
		get_node("AnimationPlayer").play("RuningLeft")
	elif not is_right_pressed and not is_left_pressed:
		can_run=true
		
	
	
	

	
