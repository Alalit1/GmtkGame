extends Resource
class_name ItemData

@export var item_id: String
@export var item_scene_damage: PackedScene
@export var damage_data: DamageData
@export var texture: AtlasTexture

@export var cost: int = 10
@export var font_size: int = 6
@export var name : String

@export_multiline var description: String = ""

@export var uses: int = 1
@export var max_uses: int = 1

@export_category("Type")
enum ItemType {
	HEAL,
	DAMAGE,
	SPEED,
	MANA
}

@export var type: ItemType

@export_enum("Potion", "Scroll") var item_type: int
## зелья
@export_group("Potion")

@export_enum("Health", "Stamina") var potion_type: int

@export var amout_heal : float
@export var stamina_amout : float

## свиткы
@export_group("Scroll")
@export_enum("Attack", "def") var scroll_type: int
@export var count_use : int = 1
