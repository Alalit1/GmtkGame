extends Control

var inventore
var hp := 100
var stamina  := 100
var last_stamina := -1
@onready var label: Label = $Panel/Label
@onready var player = get_parent().get_parent()

func _ready():
	player.hp_changed.connect(_on_hp_changed)
	player.stamina_changed.connect(_on_stamina_changed)

func _process(_delta):
	if stamina == null:
		return

	if stamina != last_stamina:
		last_stamina = stamina
		$MarginContainer/VBoxContainer/StamionaBar.set_stamina(stamina)
	

func _on_hp_changed(new_hp):
	$MarginContainer/VBoxContainer/HealthBar.set_hp(new_hp)

func _on_stamina_changed(new_stamina):
	$MarginContainer/VBoxContainer/StamionaBar.set_stamina(new_stamina)
