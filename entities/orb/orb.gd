extends Area2D

enum OrbElement { Universal, Water, Fire, Air, Earth }
@export var element: OrbElement

signal add_orb(element: OrbElement)

func _on_body_entered(body: Node2D) -> void:
	if body is not Player: return
	add_orb.emit(element)
