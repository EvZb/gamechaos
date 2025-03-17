extends Node

var arealoaded:int
var layerloaded:int

func pause(disable:bool) -> void:
	if(disable):
		set_process_input(false)
		set_physics_process(false)
		set_process(false)
	else:
		set_process_input(true)
		set_physics_process(false)
		set_process(true)

func _init() -> void:
	set_process(false)
	set_physics_process(false)
	set_process_input(false)

func _physics_process(_delta) -> void:
	D.game.time.Pass()

func spawn_player() -> void:
	add_child(load("res://scenes/game/player.tscn").instantiate())

func spawn_item() -> void:pass

func spawn_entity() -> void:pass
