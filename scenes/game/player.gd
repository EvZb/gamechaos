extends Sprite2D

#var TIS = load("res://scenes/game/player.tscn")
var area = 0
var layer = 0
var tmp

func _physics_process(_delta) -> void:
	if(Input.is_action_pressed("direction")):
		position += Vector2(Input.get_axis("ui_left","ui_right") * 128, Input.get_axis("ui_up","ui_down") * 128)
	#if(Input.is_action_just_pressed("ui_text_submit")):
	#	if(%World.visible):
	#		%Area.show()
	#		%World.hide()
	#	else:
	#		%Area.hide()
	#		%World.show()
	#if(Input.is_action_just_pressed("ui_select")):
	#	var TI = TIS.instantiate()
	#	get_parent().add_child(TI)
	#	TI.position = Vector2(128,128)
	#	TI.show()
	#if(%World.hidden):F.Move(area,layer,0,direction)
	#else:
	#	position = Vector2(position.x + direction.x * 128,position.y + direction.y * 128).clampf(0,D.game.world.Size - 1)
	#	area += direction.x + (direction.y * 128)
