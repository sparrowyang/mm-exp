extends Node2D

"""
建筑基类：
1. 支持检测鼠标移入移出
2. 支持点击
3. 支持...

外部右键->实例化子场景
若要改变材质，点击子节点可编辑
"""
@export var tile_set:TileSet # 无用
@export var build_name = "build"

class Propterty:
	var level = 0
	var price = 100
	var next_level = 500
	
var status: Propterty = Propterty.new()
var tile:TileMap
var focus = false
#var detil = preload("res://scene/UI/window.tscn")
func show_detil():
	get_node("window").msg = "name  [%s]\nlevel  %s\nprice  %s\nnext_level  %s\n"% \
							[build_name,status.level,status.price,status.next_level]
	get_node("window").show()

func hide_detil():
	get_node("window").hide()

# Called when the node enters the scene tree for the first time.
func _ready():
	tile = get_node("TileMap")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#  Input.CURSOR_MOVE
	pass
	
func _input(event):
	# print(get_viewport().get_mouse_position())
	if focus and event is InputEventMouseButton:
		print_debug("click %s" % build_name)
		show_detil()
	
# 处理鼠标移入后
# 着色器高亮建筑
func _on_static_body_2d_mouse_entered():
#	print_debug("mouse focus on 【%s】" % build_name)
#	print("mouse focus on %s" % build_name)
	focus = true
	self.scale = Vector2(1.1,1.1)
	tile.material.set_shader_parameter("focus_color",Vector4(1,1,1,1))
	tile.material.set_shader_parameter("deep",0.3)
	get_node("focus").play()
	show_detil()
	

func _on_static_body_2d_mouse_exited():
	focus = false
	self.scale = Vector2(1,1)
#	print_debug("mouse unfocus on 【%s】" % build_name)
	tile.material.set_shader_parameter("deep",0)
	pass # Replace with function body.
	hide_detil()
	
