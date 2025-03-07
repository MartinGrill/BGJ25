extends Node2D
class_name HUD

@export var water_orbs_counter : Label
@export var fire_orbs_counter : Label
@export var air_orbs_counter : Label
@export var earth_orbs_counter : Label
@export var universal_orbs_counter : Label

func update_water_orbs_counter_label(number: int):
	water_orbs_counter.text = str(number) + " x"

func update_fire_orbs_counter_label(number: int):
	fire_orbs_counter.text = str(number) + " x"
	
func update_air_orbs_counter_label(number: int):
	air_orbs_counter.text = str(number) + " x"

func update_earth_orbs_counter_label(number: int):
	earth_orbs_counter.text = str(number) + " x"

func update_universal_orbs_counter_label(number: int):
	universal_orbs_counter.text = str(number) + " x"
