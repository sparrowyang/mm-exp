extends Resource

class_name ItemImpl

@export var custom_texture:Texture2D = null
@export var custom_price:int = 0
@export var custom_name:String = "未知物品"
@export var custom_desc = "恭喜你找到游戏BUG啦！！！"


func _init(texture:Texture2D = null,price= 0, name = "", desc = ""):
	if texture != null:
		custom_texture = texture
	custom_price = price
	if name != "":
		custom_name = name
	if desc != "":
		custom_desc = desc
