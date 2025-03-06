class_name MainMenu
extends Control

@onready var start_level = preload("res://scenes/tutorial/tutorial.tscn") as PackedScene

func _on_button_start_pressed() -> void:
	get_tree().change_scene_to_packed(start_level)

func _on_button_options_pressed() -> void:
	pass # Replace with function body.

func _on_button_exit_pressed() -> void:
	get_tree().quit()
