extends Node2D
class_name BaseRoom

@export var generate_array: RoomGenerateArray
@onready var draw_map = $DrwingMap
@onready var generate_room_node: GenerateRoom = $Ganerate

var room_sequence: Array[RoomData] = []
var current_room_index: int = 0


#func _ready() -> void:
func create_room() ->void:
	# Один раз створюємо послідовність dungeon
	room_sequence = generate_room_node.generate_map(generate_array)

	print("Generated map: ", room_sequence.size())

	# Створюємо тільки перший елемент
	generate_next_room()


func generate_next_room() -> void:
	if current_room_index >= room_sequence.size():
		print("Dungeon finished")
		return

	var room: RoomData = room_sequence[current_room_index]

	print(
		"Generate element: ",
		current_room_index,
		" | ",
		room.room_name
	)

	# Генеруємо дані кімнати
	generate_room_node.generate_room(room)

	# Малюємо її
	draw_map.draw_room(room)
