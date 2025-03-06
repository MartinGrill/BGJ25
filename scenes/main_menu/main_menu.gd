class_name MainMenu
extends Control

@onready var start_level = preload("res://scenes/levels/level0/tutorial.tscn") as PackedScene
@onready var audio_player := $AudioStreamPlayer

func _on_button_start_pressed() -> void:
	get_tree().change_scene_to_packed(start_level)

func _on_button_options_pressed() -> void:
	pass # Replace with function body.

func _on_button_exit_pressed() -> void:
	get_tree().quit()

func _on_audio_stream_player_finished() -> void:
	audio_player.play()
