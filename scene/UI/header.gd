extends Node2D
@onready var msg = $"../window_border/GridContainer/msg"
# Called when the node enters the scene tree for the first time.
@onready var window_border = $"../window_border"
@onready var window = $".."
@onready var timer = $Timer

func _ready():
	update()
	timer.timeout.connect(update)
	timer.start(1)
	
func update():

	var time_dict = Time. get_datetime_dict_from_system()
	msg.text = "%s 年 %s 月 %s 日 %s 点"% [
		time_dict['year'],
		time_dict['month'],
		time_dict['day'],
		time_dict['hour']
		]
	var x = get_viewport_rect().size.x - window_border.size.x
	var y = 0
	window.position = Vector2(x,y)
	
