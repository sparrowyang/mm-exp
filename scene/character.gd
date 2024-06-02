"""
整个游戏的 角色 基类可以用于衍生人物。
"""

class_name Character
extends CharacterBody2D
"""
自定义属性
"""
@export var custom_texture:Texture2D = null
## 角色名称
@export var custom_name = ""
## 描述
@export var custom_desc = "" 
## 控制角色自动行动间隔，单位秒
## 小于等于0，不自动行动
@export var action_interval:float = 1 


# 定义的角色状态机。  角色目前的状态及目前有停止、四个朝向上、左、下、右。 
enum Status{
	IDLE = 0,
	UP = 1,
	RIGHT = 2,
	DOWN = 3,
	LEFT = 4,
}
# 角色的动画播放节点主要是用于播放角色在行动移动的时候的动画。 
@onready var anim = $Sprite2D/anim
# 角色自动决策的计时器。如果角色可以自动行动（下面的 action_interval控制）的话，那么就会通过这个计时器去。 定时作出决策。 比如说决定朝哪个方向移动。 
@onready var timer = $Timer
# 角色的碰撞形状节点就是可以决定角色在物理碰撞中的形状。
# 这个目前是没有形状，他会在子类去实现，就是在实现的时候衍生的时候去加，在这里不用加。 
@onready var shap = $shap
# 摄像机节点，用于镜头追踪。 
@onready var camera_2d = $Camera2D
# 点击时用于播放的音效。 
@onready var se_clicked = $"se-clicked"
# 下面的三个变量是角色的气泡就，目前用于显示角色的气泡心情。 它是一个精灵节点，然后包含动画和计时器。 
@onready var pop = $pop
@onready var pop_amim = $pop/popamim
@onready var poptimer = $pop/poptimer
@onready var sprite_2d = $Sprite2D

#TODO: 解耦合！
@onready var window_header = $CanvasLayer/window/window_border/GridContainer/RichTextLabel
@onready var window = $CanvasLayer/window

# 用于控制角色移动时候的变量。 
var move_offset = Vector2(0,0)
# 角色状态。 
var status:Status
# 用于表示鼠标悬停时候的状态。 
var focus = false


func _ready():
	status = Status.IDLE
	if action_interval > 0:
		timer.start(action_interval)
	timer.timeout.connect(make_decision)
	poptimer.timeout.connect(emotion.bind(false))
	if custom_texture != null:
		sprite_2d.texture = custom_texture

# 角色的做决定函数。 会随机地做决定，然后根据所做的决定去播放相应的动画。 
func make_decision():
	var ret = randi_range(0, 4)
	status = ret
	play_animation()


"""
角色的气泡动画展示，如果传入的是true，所以角色的那个气泡心情就会被显示，否则就不显示。 
"""
func emotion(flag:bool):
	if flag:
		pop.show()
		var animas:PackedStringArray = pop_amim.get_animation_list()
		var rand_index  = randi_range(0,animas.size()-1)
		pop_amim.play(animas[rand_index])
		poptimer.start(2)
	else:
		pop.hide()
		pop_amim.stop()
		
""""
动画播放根据状态播放不同的动画，比如说停止上下左右移动。  
此处还实际控制了角色移动的变量。 
"""
func play_animation():
	match status:
		Status.IDLE:
			anim.stop()
			move_offset = Vector2.ZERO
		Status.UP:
			anim.play("up")
			move_offset.y = -1
			move_offset.x = 0
		Status.RIGHT:
			anim.play("right")
			move_offset.x = +1
			move_offset.y = 0
		Status.DOWN:
			anim.play("down")
			move_offset.y = +1
			move_offset.x = 0
		Status.LEFT:
			anim.play("left")
			move_offset.x = -1
			move_offset.y = 0
"""
实际移动函数根据变量去实现移动。 
"""
func move():
#	print("move ",move_offset)
	if move_offset != Vector2.ZERO:
		move_and_collide(move_offset)

# TODO: 解耦合！
func show_detil():
	var region = Rect2(0,0,32,32)
	window_header.clear()
	window_header.add_image(sprite_2d.texture,0,0,Color(1, 1, 1, 1),5,region,null,false,"",false)
	var current_camera_size = get_viewport_rect().size
	var window_show_size = window.get_window_size()
	window.position.x = current_camera_size.x - window_show_size.x
	window.position.y = 0
	ViewControl.globle_window_value(window,ViewControl.WindowType.BUILD_MSG)
	window.update_content( "%s\n%s" % [custom_name,custom_desc])
	window.show()

	
"""
相机聚焦如果调用了这个函数，那么那个画面的相机会居中。 居中到这个节点上面。 
目前这个居中只是暂时的，也就是会暂时的聚焦，在这个上面它不会跟随人物的移动，
如果需要跟随人物的移动的话，也可以在这下面去做。 
"""
func focus_camera(flag:bool):
	var current_camera = get_viewport().get_camera_2d()
	if current_camera == null:
		print_debug("can not get camera!")
		return
	else:
		var center = current_camera.get_screen_center_position()
		var offset = center - current_camera.position
		current_camera.position = position - offset
		
#	if flag:
#		camera_2d.enabled = status
#		se_clicked.play()
#		camera_2d.make_current()
#	else:
#		pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	move()
	
"""
处理鼠标点击时的事件。目前的话会去聚焦相机，然后展示表情。 
"""
func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if(event.is_pressed()):
			focus = !focus
			show_detil()
			focus_camera(true)
			emotion(true)


func _on_mouse_entered():
	pass # Replace with function body.


func _on_mouse_exited():
	pass # Replace with function body.
