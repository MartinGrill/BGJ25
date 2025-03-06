extends Area2D

@onready var timer = $Timer
@onready var color_rect = $CanvasLayer/ColorRect
@onready var animation_player = $CanvasLayer/AnimationPlayer

@export var is_lava: bool

func _ready() -> void:
	color_rect.visible = false

# Signal that player enters death zone
func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		var player: Player = body
		
		if is_lava and player.current_element == Player.Element.Fire:
			print("passiv !!")
			return
		
		Engine.time_scale = 0.5
		color_rect.visible = true
		animation_player.play("death/fade_to_black")
		timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
