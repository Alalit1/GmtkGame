extends Panel

var texture = null

@onready var texture_rect = $TextureRect

func set_item(item: BaseItem):
	print(item)

	var sprite: Sprite2D = item.get_node("Sprite2D")
	texture_rect.texture = sprite.texture

	#item.queue_free()
	
func clear_item():
	texture_rect.texture = null
