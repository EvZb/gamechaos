extends Node

func pause(disable:bool) -> void:
	if(disable):
		set_process(false)
		$Player.set_physics_process(false)
	else:
		set_process(true)
		$Player.set_physics_process(true)

func reload() -> void: get_tree().reload_current_scene()

func _process(_delta) -> void:
	if(Input.is_action_just_pressed("direction")):
		$Player.direction = Vector2i(Input.get_axis("ui_left","ui_right"),Input.get_axis("ui_up","ui_down"))
