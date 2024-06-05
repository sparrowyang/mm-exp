extends Node2D

@onready var system = $CanvasLayer/system

func night_change(flag:bool):
	print_debug("night" ,flag)
	change_to_night(flag)
	

func change_to_night(flag:bool):
	if flag:
		material.set_shader_parameter("focus_color",Vector4(0,0,0,1))
		material.set_shader_parameter("deep",0.85)
	else:
		material.set_shader_parameter("deep",0)
	
func _ready():
	system.game_time.night_coming.connect(night_change)
	print_debug(system.game_time.night_coming.is_connected(night_change))
