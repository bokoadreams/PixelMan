extends ItemList


var pause_items = ["Continue", "Save", "End"]
#var itemsListIconTexture = preload("res://sprites/bonus/cross_01.png")
var itemsListIconTexture = preload("res://sprites/star1.png")
var itemsListEmptyIconTexture = preload("res://sprites/bonus/empty_cross1.png")
var prevSelectedIndex
var iconRegion = Rect2(0,0,100,50)
var iconSize = Vector2(100.0,100.0)
func _ready():
	set_process_input(true)
	insert_pause_items()
	set_pause_itemsList_params()
	
	
func _input(event):

	if event.is_action_pressed("ui_accept"):
		if get_node("/root/global").win:
			get_tree().set_pause(false)
			get_node("/root/global").setWinStatus(false)
			get_node("/root/global").goto_scene("res://IntroScreen.tscn")
		else:
			select_menu_item()
		
func select_menu_item():
	var selected_menu_item = get_selected_items()[0]
	print(get_item_text(get_selected_items()[0]))
	if selected_menu_item == 2:
		goto_main_game_menu()
	elif selected_menu_item == 0:
		continue_game()
func goto_main_game_menu():
	get_tree().set_pause(false)
	get_node("/root/global").reset_coins()
	get_node("/root/global").goto_scene("res://StartScene.tscn")
	
	#get_node("/root/global").goto_scene("res://Levels/LevelOne.tscn")
func insert_pause_items():
	for Item in pause_items :
		add_item(Item, itemsListEmptyIconTexture, true)
		#set_item_icon_region(pause_items.find(Item, 0), iconRegion)
		
func set_pause_itemsList_params():
	itemsListIconTexture.set_size_override(Vector2(64.0,64.0))
	select(0, true)
	set_item_icon(0, itemsListIconTexture)
	#set_item_icon_region(0, iconRegion)
	prevSelectedIndex=0
	set_icon_scale(0.6)
	#set_icon_mode(3)
	#set_fixed_icon_size(iconSize)
	
func continue_game():
	get_parent().hide()
	get_tree().set_pause(false)

func _on_ItemList_item_selected( index ):
	#print("item selected")
	set_item_icon(prevSelectedIndex, itemsListEmptyIconTexture)
	set_item_icon(get_selected_items()[0], itemsListIconTexture)
	prevSelectedIndex=get_selected_items()[0]
