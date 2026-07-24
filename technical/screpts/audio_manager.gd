extends Node

@onready var music_player: AudioStreamPlayer = $MusicPlayer
@onready var ui_sound_player: AudioStreamPlayer = $UISoundPlayer
@onready var sfx_player: AudioStreamPlayer = $SFXPlayers
@onready var environment_player: AudioStreamPlayer = $EnvironmentPlayers
@onready var master_player: AudioStreamPlayer = $MasterPlayer

@export var music_sounds: Array[AudioStream]
@export var ui_sounds: Array[AudioStream]
@export var sfx_sounds: Array[AudioStream]
@export var environment_sounds: Array[AudioStream]
@export var master_sounds: Array[AudioStream]

func play_sound(type: String,index: int) -> void:

	if index < 0 or index >= ui_sounds.size():
		print("Помилка: неправильний індекс звуку: ", index)
		return
	if type == "Music":
		music_player.stream = music_sounds[index]
		music_player.play()
	elif  type == "SFX":
		sfx_player.stream = sfx_sounds[index]
		sfx_player.play()
	elif type == "UI":
		ui_sound_player.stream = ui_sounds[index]
		ui_sound_player.play()
	elif type == "Master":
		master_player.stream = master_sounds[index]
		master_player.play()
	else:
		environment_player.stream = environment_sounds[index]
		environment_player.play()
	
	
