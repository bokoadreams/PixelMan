extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	get_node("Timer").start()


func _on_Timer_timeout():
	get_node("/root/global").goto_scene("res://StartScene.tscn")
