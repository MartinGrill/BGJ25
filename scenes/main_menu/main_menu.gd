class_name MainMenu
extends Control

@onready var start_level = preload("res://scenes/levels/level0/level0.tscn") as PackedScene
@onready var credit_level = preload("res://scenes/levels/credits/credit_level.tscn") as PackedScene
@onready var audio_player := $AudioStreamPlayer

func _on_button_start_pressed() -> void:
	get_tree().change_scene_to_packed(start_level)

func _on_button_credits_pressed() -> void:
	get_tree().change_scene_to_packed(credit_level)

func _on_button_exit_pressed() -> void:
	get_tree().quit()

func _on_audio_stream_player_finished() -> void:
	audio_player.play()
