extends Area2D

@onready var timer = $Timer
@onready var color_rect = $CanvasLayer/ColorRect
@onready var animation_player = $CanvasLayer/AnimationPlayer

func _ready() -> void:
	color_rect.visible = false

# Signal that player enters death zone
func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		Engine.time_scale = 0.5
		color_rect.visible = true
		animation_player.play("death/fade_to_black")
		body.get_node("CollisionShape2D").queue_free()
		timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
