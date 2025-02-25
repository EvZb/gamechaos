extends Sprite2D

var area = 0
var layer = 0
var tmp

func _physics_process(_delta) -> void:
	if(Input.is_action_pressed("direction")):
		position += Vector2(Input.get_axis("ui_left","ui_right") * 128, Input.get_axis("ui_up","ui_down") * 128)
