extends Control

func _ready() -> void:
	pass

func _on_confirm_pressed() -> void:
	$/root/Main/Multiplayer.hide()
	$/root/Main/StartMenu.reload()
	$/root/Main/StartMenu.show()
	V.MAIN_MENU_OPEN = false
	$/root/Main/MainMenu.hide()
	hide()

func _on_cancel_pressed() -> void:
	hide()
