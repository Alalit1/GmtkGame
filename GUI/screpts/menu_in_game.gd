extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false

func _on_continue_pressed() -> void:
	self.visible = false


func _on_settings_pressed() -> void:
	ScreenManager.change(ScreenManager.Screen.SETTINGS)


func _on_exit_pressed() -> void:
	ScreenManager.change(ScreenManager.Screen.MAIN_MENU)
