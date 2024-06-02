extends Control

var msg = ""

#func _ready():
#	self.global_position = Vector2.ZERO
@onready var window_border = $window_border

func get_window_size():
	return window_border.size
	
func update_content(s:String):
	var label_msg = $window_border/GridContainer/msg
	label_msg.text = s

func _on_visibility_changed():
	var label_msg = $window_border/GridContainer/msg
#		self.global_position = Vector2.ZERO
	label_msg.text = msg


