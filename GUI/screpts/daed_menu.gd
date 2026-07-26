extends Control



func _on_button_pressed() -> void:
	await AudioManager.play_sound("UI",1)
	ScreenManager.change(ScreenManager.Screen.MAIN_MENU)
