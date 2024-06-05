extends Control
class_name SPWindow

enum SHOW_MODE{
	TEXT,
	ITEMS,
}

@export var show_mode:SHOW_MODE = SHOW_MODE.TEXT
@onready var rich_text_label = $window_border/MarginContainer/text/RichTextLabel
@onready var text = $window_border/MarginContainer/text
@onready var items = $window_border/MarginContainer/items
@onready var cloase_btn = $window_border/MarginContainer/cloase_btn

func update_text(text:String):
	rich_text_label.text = text

func update_rich_text(content:RichTextLabel):
	rich_text_label = content

func _ready():
	match show_mode:
		SHOW_MODE.TEXT:
			text.show()
			items.hide()
			pass
		SHOW_MODE.ITEMS:
			text.hide()
			items.show()
	cloase_btn.pressed.connect(close)

func close():
	hide()
