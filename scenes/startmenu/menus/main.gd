extends Control

func _on_start_pressed() -> void:
	$/root/Main/StartMenu/Generate.Generate()
	$/root/Main/Game/Player/Camera2D.enabled = true
	$/root/Main/StartMenu.hide()
	$/root/Main/Game.pause(false)
