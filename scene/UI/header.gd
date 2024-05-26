'''
这个节点主要是用来显示窗游戏界面的提示窗口，就比如说时间啊什么的，目前的话也只有时间。 
'''

extends Node2D
@onready var msg = $"../window_border/GridContainer/msg"
# Called when the node enters the scene tree for the first time.
@onready var window_border = $"../window_border"
@onready var window = $".."
@onready var timer = $Timer

'''
节点初始化函数，这个是通过计时器每一秒去更新时间。 
'''
func _ready():
	update()
	timer.timeout.connect(update)
	timer.start(1)

''''
用于更新整个节点的内容的函数。 每调用一次，就会从系统上面获取时间，然后进行展示。 
'''
func update():
	var time_dict = Time. get_datetime_dict_from_system()
	msg.text = "%s 年 %s 月 %s 日 %s 点"% [
		time_dict['year'],
		time_dict['month'],
		time_dict['day'],
		time_dict['hour']
		]
	#var x = get_viewport_rect().size.x - window_border.size.x
	#var y = 0
	#window.position = Vector2(x,y)
	
