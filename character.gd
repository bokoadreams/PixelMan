extends RigidBody2D

var acceleration = 10000
var top_move_speed = 200
var top_jump_speed = 400
var directional_force = Vector2()

const DIRECTION = {
	ZERO = Vector2(0,0),
	LEFT = Vector2(-1,0),
	RIGHT = Vector2(1,0),
	UP = Vector2(0,-1),
	DOWN = Vector2(0,1)
}
func _integrate_forces(state):
	var final_force = Vector2()
	directional_force = DIRECTION.ZERO
	apply_force(state)
	final_force = state.get_linear_velocity() + (directional_force * acceleration)
	if(final_force.x > top_move_speed):
		final_force.x = top_move_speed
	elif(final_force.x < -top_move_speed):
		final_force.x = -top_move_speed
		
	if(final_force.y > top_jump_speed):
		final_force.y = top_jump_speed
	elif(final_force.y < -top_jump_speed):
		final_force.y = -top_jump_speed
		
	state.set_linear_velocity(final_force)


func apply_force(state):
	pass