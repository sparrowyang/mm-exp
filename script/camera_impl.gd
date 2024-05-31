extends Camera2D
class_name CameraImpl

var camera_in_draged = false
var drag_offset:Vector2 = Vector2.ZERO
func on_mouse_drag(flag:bool):
	camera_in_draged = flag
	
#func _physics_process(delta):
	#if camera_in_draged:
		#Input.mou
"""
这个脚本主要处理处表中键拖动的摄像头的变化。 
按下中键之后。 通过计算鼠标位置。 赋值给摄像头位置。 实现地图摄像头的拖动。 
"""
func _input(event):
	if event.is_action_pressed("mouse_mid"):
		drag_offset = event.position
		on_mouse_drag(true)
	elif event.is_action_released("mouse_mid") :
		on_mouse_drag(false)
	
	if camera_in_draged and event is InputEventMouseMotion:
		self.position -= event.position - drag_offset
		drag_offset = event.position
		
