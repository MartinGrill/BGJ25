extends Node

@export var tutorial_scene: PackedScene

func _ready():
	new_game()

func new_game():
	$Player.start($StartPosition.position)
