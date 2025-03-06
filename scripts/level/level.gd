class_name Level extends Node

@export_file("*.tscn") var next_level: String

@export var player : Player
@onready var tilemap = $TileMapLayer
@onready var p = $Player


func _process(delta: float) -> void:
	if not get_node_or_null("Sapling"): return
	var bodies = $Sapling.get_overlapping_bodies()
	for body in bodies:
		if isPlayer(body):
			if Input.is_action_pressed("first_ability") and p.current_element == Player.Element.Water:
				var pos = $Sapling.get_child(0).global_position
				var title_coords = tilemap.local_to_map(tilemap.to_local(pos))
				# remove sapling
				remove_child($Sapling)
				tilemap.set_cell(title_coords, -1, Vector2i(-1, -1))
				
				var vine_scene = preload("res://scenes/resources/Vine.tscn")
				var vine = vine_scene.instantiate()
				p.connectSignalsVine(vine)
				vine.position = pos
				vine.position.x -= 7
				vine.position.y -= 6
				add_child(vine)
				

func isPlayer(body):
	return body is Player
