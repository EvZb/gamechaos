extends Control

func _on_finish_pressed() -> void:
	$/root/Main/Character.reload()
	$/root/Main/Character.show()
	$/root/Main/StartMenu/Generate.GenerateWorld()
	$/root/Main/Game/Player/Camera2D.enabled = true
	$/root/Main/StartMenu.hide()
	$/root/Main/Game.pause(false)
