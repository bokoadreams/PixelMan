extends Panel

var itemsList

func _ready():
	itemsList = get_node("ItemList")
	set_process_input(true)
	

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		_on_pause_button_pressed()

func _on_pause_button_pressed():
	if not get_node("/root/global").win:
		if not get_tree().is_paused():
			show()
			itemsList.grab_focus()
			get_tree().set_pause(true)
			print("set pause true")
		else:
			hide()
			get_tree().set_pause(false)
			print("pause false")