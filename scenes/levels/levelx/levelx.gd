extends Level

@onready var audio_player := $AudioStreamPlayer

func _on_audio_stream_player_finished() -> void:
	audio_player.play()
