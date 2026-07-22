extends Node


@export var characteristic : = Characteristic
var npc: CharacterBody2D

func initialize(owner):
	npc = owner

func move_to(pos: Vector2):
	npc.navigation_agent.target_position = pos
