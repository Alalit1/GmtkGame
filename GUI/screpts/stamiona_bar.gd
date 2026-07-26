extends ProgressBar

@export var max_stamina := 100.0
var stamina := 100.0

@onready var label: Label = $Label

func _ready():
	max_value = max_stamina
	update_bar()

func set_stamina(new_value: float):
	stamina = clamp(new_value, 0.0, max_stamina)
	update_bar()

func use_stamina(amount: float):
	set_stamina(stamina - amount)

func restore_stamina(amount: float):
	set_stamina(stamina + amount)

func update_bar():
	value = stamina
	label.text = "%d / %d" % [int(stamina), int(max_stamina)]
