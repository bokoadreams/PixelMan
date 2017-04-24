extends Node2D

func _ready():
	pass
	
func removeScoreFlag():
	queue_free()
	print("score flag removed")