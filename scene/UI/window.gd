extends Control

var msg = ""

#func _ready():
#	self.global_position = Vector2.ZERO
	

func _on_visibility_changed():
	if self.visible == true: 
		var label_msg = $window_border/GridContainer/msg
#		self.global_position = Vector2.ZERO
		label_msg.text = msg
