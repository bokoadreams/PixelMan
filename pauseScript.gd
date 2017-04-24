extends Node2D


func _ready():
	set_total_coins_in_level()


func set_total_coins_in_level():
	get_node("/root/global").set_total_coins_in_level(get_node("Coins").get_children().size())
	get_node("ScoresLayer/scores_Text").set_text(get_node("/root/global").get_score_string())