extends Area2D

@onready var tilemap = $TileMapLayer
@onready var colShape = $CollisionShape2D
var time_elapsed := 0.0
var size = 0

func _process(delta: float) -> void:
	var bodies = self.get_overlapping_bodies()
	for body in bodies:
		if body is not Player: 
			continue
		var player: Player = body
	 
		if Input.is_action_pressed("first_ability") and player.current_element == Player.Element.Earth:
			time_elapsed += delta * 1.5
			var newSize = int(time_elapsed) + size
			if	newSize > size:
				time_elapsed -= 1
				
				var parentTML: TileMapLayer = self.get_parent().get_node("TileMapLayer")
				if not parentTML: return
				
				var nextBlockVector = parentTML.local_to_map(parentTML.to_local(self.position))
				nextBlockVector.y += newSize * -1
				var nextBlockAtlas = parentTML.get_cell_atlas_coords(nextBlockVector)
				if nextBlockAtlas != Vector2i(-1, -1):
					return
				
				var shape = RectangleShape2D.new()
				shape.size = colShape.shape.size
				shape.size = Vector2(16, 32 * (size+1))
				colShape.set_shape(shape)
				tilemap.set_cell(Vector2i(0, newSize * -1), 0, Vector2i(0, 0))
				size = newSize

	if Input.is_action_just_released("first_ability"):
		time_elapsed = 0


func isPlayer(body):
	return body is Player
