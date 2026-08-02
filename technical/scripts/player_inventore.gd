extends Node
#class_name PlayerInventores
signal inventory_changed

var inventore = []

func add_item(item):
	inventore.append(item)
	inventory_changed.emit()
