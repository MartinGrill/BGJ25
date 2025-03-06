class_name Level extends Node

@export_file("*.tscn") var next_level: String

@export var player : Player
@onready var tilemap = $TileMapLayer
@onready var p = $Player


func _process(delta: float) -> void:
	if self.get_children().any(isSapling): sapling_logic()
	
	if p.current_element == Player.Element.Water and Input.is_action_just_pressed("first_ability"):
		makeWaterToIce()


func makeWaterToIce() -> void:
	var waterVector = Vector2i(4, 9)
	var iceVector = Vector2i(6, 2)
	var posPlayer = p.position
	var title_coords = tilemap.local_to_map(tilemap.to_local(posPlayer))
	title_coords.x -= 2
	title_coords.y -= 2
	var celldata = tilemap.get_cell_atlas_coords(title_coords)

	for i in range(0,5):
		for j in range(0,5):
			var coords_range = Vector2i(title_coords.x + i, title_coords.y + j)
			var area_atlas_coords = tilemap.get_cell_atlas_coords(coords_range)
			var source_id = tilemap.get_cell_source_id(coords_range)
			if area_atlas_coords == waterVector and source_id == 0:
				tilemap.set_cell(coords_range, 0, iceVector)


func sapling_logic() -> void:
	for body in self.get_children():
		if isSapling(body):
			var sap: Sapling = body
			if sap.player_in_range:
				if Input.is_action_pressed("first_ability") and p.current_element == Player.Element.Earth:
					var pos = sap.global_position
					var title_coords = tilemap.local_to_map(tilemap.to_local(pos))
					# remove sapling
					remove_child(sap)
					tilemap.set_cell(title_coords, -1, Vector2i(-1, -1))
					
					var vine_scene = preload("res://scenes/resources/Vine.tscn")
					var vine = vine_scene.instantiate()
					p.connectSignalsVine(vine)
					vine.position = pos
					add_child(vine)
					

func isPlayer(body):
	return body is Player
func isSapling(body):
	return body is Sapling
