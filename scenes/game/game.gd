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
	V.GAMERUNNING = true
	set_process(false)
	set_physics_process(false)
	set_process_input(false)

func _physics_process(_delta) -> void:
	D.game.time.Pass()
	#%Player/Time.text = str(D.game.time.Times())

func spawn_player() -> void:
	var player = load("res://scenes/game/player.tscn")
	add_child(player.instantiate())
