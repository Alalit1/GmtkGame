extends ProgressBar

@export var max_hp := 100
var hp := 100

@onready var label: Label = $Label

func _ready():
	max_value = max_hp
	value = hp
	update_bar()

func set_hp(new_hp: int):
	hp = clamp(new_hp, 0, max_hp)
	update_bar()

func update_bar():
	value = hp
	label.text = "%d / %d" % [hp, max_hp]
	
