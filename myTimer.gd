extends Timer



# Called when the node enters the scene tree for the first time.
func _ready():
	one_shot = false
	timeout.connect(on_timeout)
	start(3)
	pass # Replace with function body.

func  on_timeout():
	print("time out!")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# print(time_left)
	pass
	

