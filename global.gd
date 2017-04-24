extends Node2D

var current_scene = null
var coins_collected = 0
var total_coins_in_level = 0
var scoreString 
var screen_size = OS.get_screen_size(0)
var window_size = OS.get_window_size()
var win = false


func _ready():
	OS.set_window_position(screen_size*0.5 - window_size*0.5)
	
	var root = get_tree().get_root()
	current_scene = root.get_child(1)
	
func getWinStatus():
	pass
func setWinStatus(s):
	reset_coins()
	win = s
	
func add_coins():
	coins_collected+=1


func get_collected_coins():
	return coins_collected
	
func set_total_coins_in_level(c):
	
	total_coins_in_level = c
	
func get_total_coins():
	return total_coins_in_level
	
func get_score_string():
	scoreString = "*%s" % coins_collected
	return scoreString
	
func reset_coins():
	coins_collected=0
	
	
func goto_scene(path):
	
	call_deferred("_deferred_goto_scene",path)
	
func _deferred_goto_scene(path):
	
	# Immediately free the current scene,
	# there is no risk here.
	
	current_scene.free()
	
	# Load new scene
	var s = ResourceLoader.load(path)
	
	# Instance the new scene
	current_scene = s.instance()


	# Add it to the active scene, as child of root
	get_tree().get_root().add_child(current_scene)
	
	
	# optional, to make it compatible with the SceneTree.change_scene() API
	get_tree().set_current_scene( current_scene )
	
	#print(get_tree().get_node_count())