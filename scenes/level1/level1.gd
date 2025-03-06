extends Level

#const LIMIT_LEFT = -315
#const LIMIT_TOP = -250
#const LIMIT_RIGHT = 955
#const LIMIT_BOTTOM = 690

@export var player : Player

func _ready():
	var camera = player.get_node("Camera2D")
	#camera.limit_left = LIMIT_LEFT
	#camera.limit_top = LIMIT_TOP
	#camera.limit_right = LIMIT_RIGHT
	#camera.limit_bottom = LIMIT_BOTTOM
