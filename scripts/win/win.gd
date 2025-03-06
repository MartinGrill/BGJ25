extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		print("win !!")
		var level : Level = body.get_tree().current_scene
		print(level.next_level)
		get_tree().change_scene_to_file(level.next_level)
