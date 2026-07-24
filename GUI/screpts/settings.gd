extends Control


func _on_master_value_changed(value: float) -> void:
	var bus = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(bus, value)


func _on_music_value_changed(value: float) -> void:
	var bus = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(bus, value)


func _on_sfx_value_changed(value: float) -> void:
	var bus = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_db(bus, value)


func _on_ui_value_changed(value: float) -> void:
	var bus = AudioServer.get_bus_index("UI")
	AudioServer.set_bus_volume_db(bus, value)


func _on_enviroment_value_changed(value: float) -> void:
	var bus = AudioServer.get_bus_index("Environment")
	AudioServer.set_bus_volume_db(bus, value)

func _on_master_drag_ended(value_changed: bool) -> void:
	AudioManager.play_sound("Master",0)


func _on_music_drag_ended(value_changed: bool) -> void:
	AudioManager.play_sound("Music",0)


func _on_effects_drag_ended(value_changed: bool) -> void:
	AudioManager.play_sound("SFX",0)


func _on_ui_drag_ended(value_changed: bool) -> void:
	AudioManager.play_sound("UI",0)


func _on_enviroment_drag_ended(value_changed: bool) -> void:
	AudioManager.play_sound("Env",0)


func _on_back_pressed() -> void:
	AudioManager.play_sound("UI",1)
	ScreenManager.change(ScreenManager.Screen.MAIN_MENU)
