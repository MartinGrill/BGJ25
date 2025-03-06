extends Area2D

@onready var timer = $Timer
@onready var color_rect = $CanvasLayer/ColorRect
@onready var animation_player = $CanvasLayer/AnimationPlayer

@export var is_lava: bool

var dead := false

func _ready() -> void:
	color_rect.visible = false
	
func _process(delta: float) -> void:
	if dead: return
	
	for body in self.get_overlapping_bodies():
		if body is not Player or (is_lava and body.current_element == Player.Element.Fire): return
		
		Engine.time_scale = 0.5
		color_rect.visible = true
		animation_player.play("death/fade_to_black")
		dead = true
		
		timer.start()
		

func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
