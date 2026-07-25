extends Area2D
class_name BaseItem

@export var item_data : ItemData
@onready var sprite = $Sprite2D
@onready var label = $Label

var item_use := false
var cost

func _ready() -> void:
	cost = item_data.cost
	sprite.texture = item_data.texture
	label.visible = false
	
	label.position = self.position
	label.position.x = self.position.x + 46
	label.text = item_data.name + "\n" +item_data.description

func use(player) -> void:
	pass
	
func pick_up(player) -> void:
	player.buy(cost)
	if player.inventory.add_item(item_data):
		queue_free()

func _on_mouse_entered() -> void:
	item_use = true
	label.visible = true

func _on_mouse_exited() -> void:
	item_use = false
	label.visible = false
