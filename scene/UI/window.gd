extends Node2D

var msg = ""
var interval = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	position = Vector2()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#这里设置的是相对于父节点的位置
#	self.position = get_global_mouse_position()
	self.global_position = get_global_mouse_position()
	interval+=delta
	if interval >1:
		interval = 0
		print(self.position,delta)
		
func _process(delta):

	pass

func _on_visibility_changed():
	if self.visible == true: 
		var label_msg = get_node("Sprite2D/msg")
		label_msg.text = msg
	pass # Replace with function body.
