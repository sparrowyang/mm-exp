class_name Character
extends CharacterBody2D

enum Status{
	IDLE = 0,
	UP = 1,
	RIGHT = 2,
	DOWN = 3,
	LEFT = 4,
}
@onready var anim = $Sprite2D/anim
@onready var timer = $Timer
@onready var shap = $shap
@onready var camera_2d = $Camera2D
@onready var se_clicked = $"se-clicked"


var move_offset = Vector2(0,0)
var status:Status
var focus = false
## 控制角色自动行动间隔，单位秒
## 小于等于0，不自动行动
@export var action_interval:float = 1 


func _ready():
	status = Status.IDLE
	timer.start(action_interval)
	timer.timeout.connect(make_decision)
	
func make_decision():
	var ret = randi_range(0, 4)
	status = ret
	play_animation()

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
			
func move():
#	print("move ",move_offset)
	if move_offset != Vector2.ZERO:
		move_and_collide(move_offset)
		
func show_detil():
	pass

func focus_camera(flag:bool):
	print_debug(flag)
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
	
# clicked
func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if(event.is_pressed()):
			focus = !focus
			show_detil()
			focus_camera(true)


func _on_mouse_entered():
	pass # Replace with function body.


func _on_mouse_exited():
	pass # Replace with function body.
