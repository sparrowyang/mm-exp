extends Node2D

class SPGameTIme:
	var year = 1
	var month = 1
	var date = 1
	var hour = 0
	signal night_coming(flag:bool)
	func tick():
		hour+=1
		if hour >24:
			hour = 0
			date+=1
			if date > 30:
				date = 1
				month+=1
				if month >12:
					month = 1
					year +=1
		
		if hour == 18 :
			night_coming.emit(true)
		elif hour ==6 :
			night_coming.emit(false)
		
	func get_timer_now():
		return "大破坏 %d年 %d月 %d日 %d时" % [year,month,date,hour]


var game_time:SPGameTIme = SPGameTIme.new()

@onready var time_ui = $time_ui
@onready var timer = $Timer

func update_time():
	game_time.tick()
	time_ui.update_text(game_time.get_timer_now())
	
# Called when the node enters the scene tree for the first time.
func _ready():
	time_ui.update_text(game_time.get_timer_now())
	timer.start(1)
	timer.timeout.connect(update_time)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
