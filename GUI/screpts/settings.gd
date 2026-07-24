extends Control

@onready var stream = $TestAudio
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_master_value_changed(value: float) -> void:
	var bus = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(bus, value)


func _on_music_value_changed(value: float) -> void:
	var bus = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(bus, value)


func _on_effects_vallue_changed(value: float) -> void:
	var bus = AudioServer.get_bus_index("Effects")
	AudioServer.set_bus_volume_db(bus, value)


func _on_ui_value_changed(value: float) -> void:
	var bus = AudioServer.get_bus_index("UI")
	AudioServer.set_bus_volume_db(bus, value)


func _on_enviroment_value_changed(value: float) -> void:
	var bus = AudioServer.get_bus_index("Environment")
	AudioServer.set_bus_volume_db(bus, value)

func _on_master_drag_ended(value_changed: bool) -> void:
	stream.play()


func _on_music_drag_ended(value_changed: bool) -> void:
	stream.play()


func _on_effects_drag_ended(value_changed: bool) -> void:
	stream.play()


func _on_ui_drag_ended(value_changed: bool) -> void:
	stream.play()


func _on_enviroment_drag_ended(value_changed: bool) -> void:
	stream.play()


func _on_back_pressed() -> void:
	#$UI.play()
	ScreenManager.change(ScreenManager.Screen.MAIN_MENU)
