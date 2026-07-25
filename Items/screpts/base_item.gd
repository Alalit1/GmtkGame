extends Area2D
class_name BaseItem

@export var item_data : ItemData
@onready var sprite = $Sprite2D
@onready var label = $Label

var item_use := false
var cost = 10

var player = null

func _ready() -> void:
	cost = item_data.cost
	sprite.texture = item_data.texture
	label.visible = false
	
	label.position = self.position
	label.position.x = self.position.x + 46
	label.text = item_data.name + "\n" +item_data.description

func use(player) -> void:
	pass

func _process(delta):
	if Input.is_action_just_released("LKM") and item_use:
		pick_up()

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


func _on_area_2d_body_entered(body: Player) -> void:
	player = body


func _on_area_2d_body_exited(body: Player) -> void:
	player = body
