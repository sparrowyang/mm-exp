extends Node2D

"""
建筑基类：
1. 支持检测鼠标移入移出
2. 支持点击
3. 支持...

外部右键->实例化子场景
若要改变材质，点击子节点可编辑
"""

@export var build_name = "build"

"""
建筑的属性目前的话包含了等级价值，还有距离下一个等级的经验值。 
"""
class Propterty:
	var level = 0
	var price = 100
	var next_level = 500
	
var status: Propterty = Propterty.new()


# 用于表示鼠标是否处于悬停上的状态。 
var focus = false
# 材质的图节点主要是用这个去控制着色器，然后改变节点的颜色。 
@onready var tile_map = $TileMap

#var detil = preload("res://scene/UI/window.tscn")
func show_detil():
	get_node("window").msg = "name  [%s]\nlevel  %s\nprice  %s\nnext_level  %s\n"% \
							[build_name,status.level,status.price,status.next_level]
	get_node("window").show()

func hide_detil():
	get_node("window").hide()


"""
处理鼠标点击该节点的时候的事件。如果鼠标点击的建筑就会通过show_detil去展示信息。 
"""
func _input(event):
	# print(get_viewport().get_mouse_position())
	if focus and event is InputEventMouseButton:
		print_debug("click %s" % build_name)
		if(event.is_pressed()):
			get_node("focus").play()
			show_detil()
			ViewControl.focus_camera(self)

"""
处理鼠标悬停时的颜色变化。如果鼠标在个节点的上面，然后会调用 着色器 去改变整个节点的颜色。 
"""
func _on_static_body_2d_mouse_entered():
#	print_debug("mouse focus on 【%s】" % build_name)
#	print("mouse focus on %s" % build_name)
	focus = true
	self.scale = Vector2(1.1,1.1)
	tile_map.material.set_shader_parameter("focus_color",Vector4(1,1,1,1))
	tile_map.material.set_shader_parameter("deep",0.3)
	
#	show_detil()
	

func _on_static_body_2d_mouse_exited():
	focus = false
	self.scale = Vector2(1,1)
#	print_debug("mouse unfocus on 【%s】" % build_name)
	tile_map.material.set_shader_parameter("deep",0)
	pass # Replace with function body.
	hide_detil()
	
