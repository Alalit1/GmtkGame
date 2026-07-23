extends Resource
class_name ItemData

@export var id : int

@export var texture: Texture2D

@export var cost: int

@export var name : String

@export_multiline var description: String = ""

@export_category("Type")
@export_enum("Potion", "Scroll") var item_type: int
## зелья
@export_group("Potion")

@export_enum("Health", "Stamina") var potion_type: int
@export var time :float
@export var count : float
@export var interval : float
## свиткы
@export_group("Scroll")
@export_enum("Attack", "def") var scroll_type: int
@export var count_use : int

#effects
"""
@export var id: StringName
@export var name: String
@export var description: String
@export var icon: Texture2D
@export var weight: float
@export var value: int
"""
