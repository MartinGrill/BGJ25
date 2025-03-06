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
	 
		if Input.is_action_pressed("first_ability") and player.current_element == Player.Element.Water:
			time_elapsed += delta
			var newSize = int(time_elapsed) + size
			if	newSize > size:
				var shape = RectangleShape2D.new()
				shape.size = colShape.shape.size
				shape.size = Vector2(16, 32 * (size+1))
				colShape.set_shape(shape)
				
				time_elapsed -= 1
				size = newSize
				tilemap.set_cell(Vector2i(0, size * -1), 0, Vector2i(2, 8))

	if Input.is_action_just_released("first_ability"):
		time_elapsed = 0


func isPlayer(body):
	return body is Player
