extends "res://character.gd"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
func _ready():
	acceleration = 1000
	top_move_speed  = 200
	top_jump_speed = 400
	
func apply_force(state):
	if Input.is_action_pressed("ui_left"):
		directional_force += DIRECTION.LEFT

		
	if Input.is_action_pressed("ui_right"):
		directional_force += DIRECTION.RIGHT
	
	#if Input.is_action_pressed("ui_up"):
		#directional_force += DIRECTION.UP