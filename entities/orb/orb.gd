class_name Orb extends Area2D

enum Element { Universal, Water, Fire, Air, Earth }
@export var element: Element

@onready var audio_player := $AudioStreamPlayer

var already_collected := false

func _ready() -> void:	
	match element:
		Element.Universal: $Universal.visible = true
		Element.Water: $Water.visible = true
		Element.Fire: $Fire.visible = true
		Element.Air: $Air.visible = true
		Element.Earth: $Earth.visible = true

func _on_body_entered(body: Node2D) -> void:
	if body is not Player or already_collected: return
	
	var player: Player = body
	player.add_switch(element)
		
	audio_player.play()
	
	already_collected = true
	self.visible = false
