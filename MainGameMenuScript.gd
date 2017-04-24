extends ItemList


var pause_items = ["New game", "Exit"]
#var itemsListIconTexture = preload("res://sprites/bonus/cross_01.png")
var itemsListIconTexture = preload("res://sprites/star1.png")
var itemsListEmptyIconTexture = preload("res://sprites/bonus/empty_cross1.png")
var prevSelectedIndex
var iconRegion = Rect2(0,0,100,50)
var iconSize = Vector2(100.0,100.0)

func _ready():
	grab_focus()
	set_process_input(true)
	insert_pause_items()
	set_pause_itemsList_params()
	
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		print("MAIN MENU")
		var selected_menu_item =  get_selected_items()[0]
		print(get_item_text(get_selected_items()[0]))
		if selected_menu_item == 0:
			start_new_game()
	
	
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
	
	

func start_new_game():
	get_node("/root/global").goto_scene("res://Levels/LevelOne.tscn")



func _on_MenuItems_item_selected( index ):
	set_item_icon(prevSelectedIndex, itemsListEmptyIconTexture)
	set_item_icon(get_selected_items()[0], itemsListIconTexture)
	prevSelectedIndex=get_selected_items()[0]
