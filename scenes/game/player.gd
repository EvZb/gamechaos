extends Node2D

var layers
var direction:Vector2i

func _ready() -> void:
	layers = %World/Layers

func _physics_process(_delta) -> void:
	if(Input.is_action_pressed("direction")):
		direction = Vector2i(Input.get_axis("ui_left","ui_right"),Input.get_axis("ui_up","ui_down"))
	position.y = clamp(position.y + (direction.y * 128),64,16320)
	position.x = clamp(position.x + (direction.x * 128),64,16320)
	direction = Vector2i()
	if(Input.is_action_just_pressed("ui_text_submit")):
		var layer0 = layers.get_child(0)
		var layer1 = layers.get_child(1)
		layer0.show()
		layers.move_child(layer1,0)
		layer1.hide()
	if(Input.is_action_just_pressed("ui_select")):
		var TIS = load("res://Assets/items/test_item.tscn")
		var TI = TIS.instantiate()
		layers.get_child(1).add_child(TI)
		TI.position = position
		TI.show()
