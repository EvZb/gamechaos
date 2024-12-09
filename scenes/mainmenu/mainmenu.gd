extends Control

func hide_menus() -> void:
	$SubMenu/Initial.hide()
	$SubMenu/Saves.hide()
	$SubMenu/Settings.hide()

func _ready() -> void:
	hide_menus()
	$SubMenu/Initial.show()
	if(V.MULTIPLAYER): $SubMenu/Saves/LoadButtons.hide()

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_icon_pressed() -> void:
	if($SubMenu/Initial.visible):
		$SubMenu/Initial.hide()
	else:
		hide_menus()
		$SubMenu/Initial.show()

func _on_saves_pressed() -> void:
	if($SubMenu/Saves.visible): $SubMenu/Saves.hide()
	else:
		hide_menus()
		$SubMenu/Saves.show()

func _on_start_pressed() -> void:
	if($SubMenu/Start.visible): $SubMenu/Start.hide()
	else:
		hide_menus()
		$SubMenu/Start.show()

func _on_multiplayer_pressed() -> void:
	V.MULTIPLAYER = true
	$/root/Main/Multiplayer.reload()
	$/root/Main/Multiplayer.show()
	$/root/Main/StartMenu.hide()
	V.MAIN_MENU_OPEN = false
	hide()
	hide_menus()
	$SubMenu/Settings.hide_menus()

func _on_settings_pressed() -> void:
	if($SubMenu/Settings.visible): $SubMenu/Settings.hide()
	else:
		hide_menus()
		$SubMenu/Settings.hide_menus()
		$SubMenu/Settings.show()
