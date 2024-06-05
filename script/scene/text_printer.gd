extends RichTextLabel
var printer_ebable:bool = false
var pre_show_content:String
var pre_show_content_len = 0
var show_end = false
var showing_index = 0
@onready var show_timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	if printer_ebable:
		pre_show_content = text
		pre_show_content_len = text.length()
		text = ""
		show_timer.timeout.connect(printing)
		show_timer.start(0.1)

func printing():
	if showing_index < pre_show_content_len:	
		add_text(pre_show_content[showing_index])
		showing_index += 1
# Called every frame. 'delta' is the elapsed time since the previous frame.

