extends Area2D
class_name BaseItem

@export var item_data : ItemData

@onready var audio = $AudioStreamPlayer2D
@onready var sprite = $Sprite2D
@onready var label = $CanvasLayer/Label
@onready var interect_area = $interection_area

var item_use := false
var cost = 10

var player = null

func _ready() -> void:
	var texture = item_data.texture
	
	cost = item_data.cost
	
	sprite.texture = item_data.texture
	# font
	label.text = item_data.name + "\n" +item_data.description
	label.add_theme_font_size_override("font_size", item_data.font_size)
	
	label.position.y = self.position.y
	label.position.x = self.position.x+ 40
	
func use(user: Node):
	item_data.use(user)


func _process(_delta: float) -> void:
	if player != null:
		label.visible = true

	if player != null and Input.is_action_just_pressed("LK"):

		pick_up(player)

func pick_up(player) -> void:
	$CollisionShape2D.set_deferred("disabled", true)
	monitoring = false
	TimeGlobal.time -= cost
	
	if get_parent() != null:
		get_parent().remove_child(self)
	PlayerInventore.add_item(self)

func _on_area_2d_body_entered(body: Player) -> void:
	player = body
	
func _on_area_2d_body_exited(body: Player) -> void:
	player = null
	label.visible = false
