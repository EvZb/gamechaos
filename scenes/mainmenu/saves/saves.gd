extends Control
#Time.get_datetime_string_from_system()

func _on_save_pressed(num:int) -> void:
	F.SaveWorld("test",num)

func _on_load_pressed(num:int) -> void:
	F.LoadWorld("test",num)

func LoadMenu() -> void:
	if(V.MULTIPLAYER): $Saves/LoadButtons.hide()
	else: $Saves/LoadButtons.show()
	if(V.GAMERUNNING):
		$Saves/SaveButtons.show()
		$Saves.show()
		$Worlds.hide()
	else:
		$Saves/SaveButtons.hide()
		$Worlds.show()
		$Saves.hide()
