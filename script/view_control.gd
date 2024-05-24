"""
这里这个文件是打算做视图控制的，就是做一些。 
嗯，动画啊，移动什么的，
这个文件对于整个项目来说是全局的就是说任何地方都能用这个里的函数。 
"""
extends Node



func focus_camera(target:Node):
	var current_camera = get_viewport().get_camera_2d()
	if current_camera == null:
		print_debug("can not get camera!")
		return
	else:
		var center = current_camera.get_screen_center_position()
		var offset = center - current_camera.position
		current_camera.position = target.position - offset
