class_name Orb extends Area2D

enum OrbElement { Universal, Water, Fire, Air, Earth }
@export var element: OrbElement

@onready var water = $Water
@onready var fire = $Fire
@onready var air = $Air
@onready var earth = $Earth
@onready var universal = $Universal

func _ready() -> void:	
	match element:
		OrbElement.Universal: universal.visible = true
		OrbElement.Water: water.visible = true
		OrbElement.Fire: fire.visible = true
		OrbElement.Air: air.visible = true
		OrbElement.Earth: earth.visible = true

func _on_body_entered(body: Node2D) -> void:
	if body is not Player: return
	
	var player: Player = body
	player.add_switch(element)
	
	self.queue_free()
