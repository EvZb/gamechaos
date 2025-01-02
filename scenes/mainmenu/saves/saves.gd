extends Control
#Time.get_datetime_string_from_system()


func _on_save_pressed() -> void:
	F.SaveWorld("test",0)


func _on_load_pressed() -> void:
	F.LoadWorld("test",0)
