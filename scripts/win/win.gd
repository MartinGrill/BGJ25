extends Area2D

@onready var timer := $Timer
@onready var color_rect := $CanvasLayer/ColorRect
@onready var animation_player := $CanvasLayer/AnimationPlayer
@onready var audio_player := $AudioStreamPlayer

func _ready() -> void:
	color_rect.visible = false

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		Engine.time_scale = 0.5
		color_rect.visible = true
		animation_player.play("win/fade_to_white")
		audio_player.play()
		# body.get_node("CollisionShape2D").queue_free()
		timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	var level : Level = get_tree().current_scene
	if level.next_level == null: return
	var scene = load(level.next_level) as PackedScene
	get_tree().change_scene_to_packed(scene)
