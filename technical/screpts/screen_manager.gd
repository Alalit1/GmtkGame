extends Node

enum Screen{
	MAIN_MENU,
	SETTINGS,
	GAME,
	PAUSE,
	GAME_OVER,
	LOADING
}

const SCREENS := {
	Screen.MAIN_MENU : "res://GUI/screens/main_menu.tscn",
	Screen.SETTINGS : "res://GUI/screens/settings.tscn",
	Screen.GAME : "res://rooms/game.tscn",
	#Screen.GAME_OVER : "res://screens/game_over.tscn",
	#Screen.LOADING : "res://screens/loading.tscn",
}

signal screen_changed(screen)

func change(screen: Screen):

	get_tree().change_scene_to_file(SCREENS[screen])

	screen_changed.emit(screen)
