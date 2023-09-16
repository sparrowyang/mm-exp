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
