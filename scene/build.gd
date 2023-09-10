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

var tile:TileMap
# Called when the node enters the scene tree for the first time.
func _ready():
#	var body = get_node("StaticBody2D")
#	tile = get_node("TileMap")
#	tile.tile_set.set_tileset(tile_set)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#  Input.CURSOR_MOVE
	pass
func _input(event):
	# print(get_viewport().get_mouse_position())
	pass

# 处理鼠标移入后
# 着色器高亮建筑
func _on_static_body_2d_mouse_entered():
	print_debug("mouse focus on 【%s】" % build_name)
#	print("mouse focus on %s" % build_name)
	tile.material.set_shader_parameter("focus_color",Vector4(1,1,1,1))
	tile.material.set_shader_parameter("deep",0.3)
	pass # Replace with function body.
	get_node("focus").play()

func _on_static_body_2d_mouse_exited():
	print_debug("mouse unfocus on 【%s】" % build_name)
	tile.material.set_shader_parameter("deep",0)
	pass # Replace with function body.
