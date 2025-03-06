class_name Level extends Node

@export_file("*.tscn") var next_level: String

var time_elapsed := 0.0

@export var player : Player
@onready var tilemap = $TileMapLayer

func _process(delta: float) -> void:
	var bodies = $Sapling.get_overlapping_bodies()
	for body in bodies:
		if isPlayer(body):
			if Input.is_action_pressed("first_ability"): # and water is selected
				time_elapsed += delta
				var pos = $Sapling.get_child(0).position
				var title_coords = tilemap.local_to_map(tilemap.to_local(pos))
				
				# TODO Erneutes Starten vom Gießen nicht unten anfangen, sondern beim obersten Teil
				title_coords.y += int(time_elapsed) * -1
				tilemap.set_cell(title_coords, 0, Vector2i(2, 8))
				
			if Input.is_action_just_released("first_ability"):
				time_elapsed = 0
				
	if not bodies.any(isPlayer):
		time_elapsed = 0

func isPlayer(body):
	return body is Player
