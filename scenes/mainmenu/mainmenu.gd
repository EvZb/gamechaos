extends CanvasLayer

func hide_menus() -> void:
	$SubMenu/Initial.hide()
	$SubMenu/Saves.hide()
	$SubMenu/Settings.hide()

func _ready() -> void:
	hide_menus()
	$SubMenu/Initial.show()

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_icon_pressed() -> void:
	if($SubMenu/Initial.visible):
		$SubMenu/Initial.hide()
	else:
		hide_menus()
		$SubMenu/Initial.show()

func _on_save_pressed() -> void:
	if($SubMenu/Saves.visible): $SubMenu/Saves.hide()
	else:
		$SubMenu/Saves.LoadMenu()
		hide_menus()
		$SubMenu/Saves.show()

func _on_start_pressed() -> void:
	if($SubMenu/Start.visible): $SubMenu/Start.hide()
	else:
		hide_menus()
		$SubMenu/Start.show()

func _on_multiplayer_pressed() -> void:
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

func _on_leave_pressed() -> void:
	hide_menus()
	$SubMenu/Initial.show()
	$Options/Leave.hide()
	$Options/Start.show()
	$/root/Main/Multiplayer.Leave()
	$/root/Main/Game.free()

func _on_disconnect_pressed() -> void:
	$/root/Main/Multiplayer.Leave()
	$Options/Disconnect.hide()
	$Options/Leave.show()
