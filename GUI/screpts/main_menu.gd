extends Control



@onready var menu_sound = $MenuSound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_game_pressed() -> void:
	await AudioManager.play_sound("UI",1)
	ScreenManager.change(ScreenManager.Screen.GAME)


func _on_settings_pressed() -> void:
	await AudioManager.play_sound("UI",1)
	ScreenManager.change(ScreenManager.Screen.SETTINGS)


func _on_exit_pressed() -> void:
	await AudioManager.play_sound("UI",1)
	get_tree().quit()
