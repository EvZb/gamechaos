extends Control

var Setting = S.Load("Game")

func _ready() -> void:
	$TickRate.select(Setting["TickRate"]-1)
	$AutoTick.select(Setting["AutoTick"])
	Engine.physics_ticks_per_second = S.Game["TickRate"]

func _on_apply_pressed() -> void:
	Setting["TickRate"]=$TickRate.get_selected_id()+1
	Engine.physics_ticks_per_second = S.Game["TickRate"]
	Setting["AutoTick"]=$AutoTick.get_selected_id()
	S.Save("Game",Setting)
