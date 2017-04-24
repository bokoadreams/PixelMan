extends Area2D
var taken = false
var score_flag = preload("res://score_flag.tscn")
var sf = null
func _ready():
	get_node("anim2").play("flash")
	sf = score_flag.instance()
	

func _on_body_enter( body ):
	if not taken and body.get_name()=="player":
		get_node("anim").play("taken")
		updateScores()
		showScoreFlag()
		taken=true
		
func showScoreFlag():
	sf.get_node("Label").set_text("100")
	sf.set_pause_mode(2)
	var pos = get_pos() - Vector2(30, 110)
	sf.set_pos(pos)
	get_parent().add_child(sf)
	sf.get_node("anim").play("fadeup")

	
func updateScores():
	var scoresTextLabel = get_parent().get_parent().get_node("ScoresLayer").get_node("scores_Text")
	get_node("/root/global").add_coins()
	scoresTextLabel.set_text(get_node("/root/global").get_score_string())
	
	if (get_node("/root/global").get_collected_coins() == get_node("/root/global").get_total_coins()):
		get_parent().get_parent().get_node("winLayer").get_node("youwin").show()
		get_parent().get_parent().get_node("winLayer").get_node("anim").play("press_enter")
		#print(get_parent().get_parent().get_name())
		get_node("/root/global").setWinStatus(true)
		
		get_parent().get_parent().get_node("TileMap").set_pause_mode(2)
		for node in get_parent().get_parent().get_node("Enemies").get_children():
			node.set_pause_mode(2)
			for node2  in node.get_children():
				node2.set_pause_mode(2)
				
		for node in get_parent().get_parent().get_node("Coins").get_children():
			node.set_pause_mode(2)
			for node2  in node.get_children():
				node2.set_pause_mode(2)
		for node in get_parent().get_parent().get_node("ScoresLayer").get_children():
			node.set_pause_mode(2)
			for node2  in node.get_children():
				node2.set_pause_mode(2)
				
		
		
		get_tree().set_pause(true)
		
		
func _on_anim_finished():
	pass
	

func _on_anim_animation_started( name ):
	pass
