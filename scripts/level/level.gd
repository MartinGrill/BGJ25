class_name Level extends Node

@export_file("*.tscn") var next_level: String

var time_elapsed := 0.0

@export var player : Player
@onready var tilemap = $TileMapLayer
@onready var p = $Player

func _process(delta: float) -> void:
	var bodies = $Sapling.get_overlapping_bodies()
	for body in bodies:
		if isPlayer(body):
			if Input.is_action_pressed("first_ability") and p.current_element == Player.Element.Water: # and water is selected
				time_elapsed += delta
				var pos = $Sapling.get_child(0).global_position
				var title_coords = tilemap.local_to_map(tilemap.to_local(pos))
				
				# hide sapling
				tilemap.set_cell(title_coords, -1, Vector2i(-1, -1))
				
				var vine_scene = preload("res://scenes/resources/Vine.tscn")
				var vine = vine_scene.instantiate()
				vine.position = pos
				vine.position.x -= 7
				vine.position.y -= 6
				add_child(vine)
				
			if Input.is_action_just_released("first_ability"):
				time_elapsed = 0
				
	if not bodies.any(isPlayer):
		time_elapsed = 0

func isPlayer(body):
	return body is Player
