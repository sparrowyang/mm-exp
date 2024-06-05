extends ScrollContainer

@onready var items = $items
const GAME_DATA = preload("res://asset/items_define.tres")

func _ready():
	for item in GAME_DATA.weapon_data:
		items.add_item(item.custom_name,item.custom_texture)
