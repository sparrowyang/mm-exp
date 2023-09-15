extends Node2D
@onready var time = $system/time

var swag = 0
var step = 1
func on_timer_timeout():
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	time
	pass # Replace with function body.
#	get_node("bar").get_node("TileMap").set_cell(1,Vector2i(1,1),1,Vector2i(1,4))
#	get_node("Timer").timeout.connect(on_timer_timeout)
#	get_node("bgm").play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
