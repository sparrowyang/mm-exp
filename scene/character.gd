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
var move_offset = Vector2(0,0)
var status:Status

func _ready():
	status = Status.IDLE
	timer.start(1)
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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	move()
	pass
