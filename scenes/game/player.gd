extends Node2D

var layers
var direction:Vector2i
var currentlayer:String = "World"
var TIS = load("res://Assets/items/test_item.tscn")

func _ready() -> void:
	layers = %World/Layers

func _physics_process(_delta) -> void:
	D.time.Pass()
	if(Input.is_action_pressed("direction")):
		direction = Vector2i(Input.get_axis("ui_left","ui_right"),Input.get_axis("ui_up","ui_down"))
	position.y = clamp(position.y + (direction.y * 128),64,16320)
	position.x = clamp(position.x + (direction.x * 128),64,16320)
	direction = Vector2i()
	if(Input.is_action_just_pressed("ui_text_submit")):
		if(currentlayer == "World"):
			layers.get_node("Area").show()
			layers.get_node("World").hide()
			currentlayer = "Area"
		else:
			layers.get_node("Area").hide()
			layers.get_node("World").show()
			currentlayer = "World"
	if(Input.is_action_just_pressed("ui_select")):
		var TI = TIS.instantiate()
		layers.get_node("World").add_child(TI)
		TI.position = position
		TI.show()
