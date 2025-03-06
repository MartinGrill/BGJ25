class_name Player extends CharacterBody2D

const WALK_SPEED = 6000.0
const JUMP_VELOCITY = -280.0
## Maximum speed at which the player can fall.
const TERMINAL_VELOCITY = 300
# var screen_size # Size of the game window.

var gravity: int = ProjectSettings.get("physics/2d/default_gravity")
@onready var platform_detector := $PlatformDetector as RayCast2D
@onready var sprite := $AnimatedSprite2D
@onready var audio_player := $JumpPlayer

var _double_jump_charged := false
var is_climbing := false
var vine_entered := false

var switches = {
	"water": 0,
	"fire": 0,
	"air": 0,
	"earth": 0,
	"universal": 0
}

func _physics_process(delta: float) -> void:
	if is_on_floor():
		_double_jump_charged = true
	if Input.is_action_just_pressed("jump"):
		try_jump()
	elif Input.is_action_just_released("jump") and velocity.y < 0.0:
		# The player let go of jump early, reduce vertical momentum.
		velocity.y *= 0.6
	
	#climbing
	var directionVertical = Input.get_axis("move_down", "move_up")
	if directionVertical != 0:
		# check if collsionshape 
		if vine_entered:
			is_climbing = true
		else:
			is_climbing = false
	else:
		is_climbing = false
	
	if not is_climbing:
		# Fall.
		velocity.y = minf(TERMINAL_VELOCITY, velocity.y + gravity * delta)
	else:
		velocity.y = JUMP_VELOCITY * delta * directionVertical * 20
	
	var direction := Input.get_axis("move_left", "move_right") * WALK_SPEED
	velocity.x = direction * delta
	
	if velocity.x != 0:
		sprite.play()
		sprite.animation = "walk"
		sprite.flip_h = velocity.x < 0
	else:
		sprite.stop()
	
	floor_stop_on_slope = not platform_detector.is_colliding()
	move_and_slide()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("change_water"): change_element(Element.Water)
	if Input.is_action_just_pressed("change_fire"): change_element(Element.Fire)
	if Input.is_action_just_pressed("change_air"): change_element(Element.Air)
	if Input.is_action_just_pressed("change_earth"): change_element(Element.Earth)

func try_jump() -> void:
	if is_on_floor():
		audio_player.play()
		pass
	elif _double_jump_charged and current_element == Element.Air:
		audio_player.play()
		_double_jump_charged = false
		velocity.x *= 2.5
	else:
		return
	velocity.y = JUMP_VELOCITY

## Element system (TODO)
enum Element { Neutral, Water, Fire, Air, Earth }
var current_element : Element

func change_element(element: Element):	
	match element:
		Element.Water:
			if(switches.get("water") >= 1):
				switches.set("water", switches.get("water")-1)
				_change_element_prime(element)
				return
		Element.Fire:
			if(switches.get("fire") >= 1):
				switches.set("fire", switches.get("fire")-1)
				_change_element_prime(element)
				return
		Element.Air:
			if(switches.get("air") >= 1):
				switches.set("air", switches.get("air")-1)
				_change_element_prime(element)
				return
		Element.Earth:
			if(switches.get("earth") >= 1):
				switches.set("earth", switches.get("earth")-1)
				_change_element_prime(element)
				return
		Element.Neutral:
			printerr("Can't change to neutral")
		
	if(switches.get("universal") >= 1):
		var n = switches.get("universal")
		switches.set("universal", n-1)
		_change_element_prime(element)
		return
	
	
func _change_element_prime(element: Element):
	self.current_element = element
	match element:
		Element.Water: sprite.sprite_frames = load("res://entities/player/assets/player_blue.tres")
		Element.Fire: sprite.sprite_frames = load("res://entities/player/assets/player_red.tres")
		Element.Air: sprite.sprite_frames = load("res://entities/player/assets/player_grey.tres")
		Element.Earth: sprite.sprite_frames = load("res://entities/player/assets/player_green.tres")
		Element.Neutral: sprite.sprite_frames = load("res://entities/player/assets/player_neutral.tres")

func _ready() -> void:
		_change_element_prime(Element.Neutral)
		
func add_switch(element: Orb.OrbElement) -> void:
	match element:
		Orb.OrbElement.Universal: switches.set("universal", switches.get("universal") + 1)
		Orb.OrbElement.Water: switches.set("water", switches.get("water") + 1)
		Orb.OrbElement.Fire: switches.set("fire", switches.get("fire") + 1)
		Orb.OrbElement.Air: switches.set("air", switches.get("air") + 1)
		Orb.OrbElement.Earth: switches.set("earth", switches.get("earth") + 1)
	print(switches)
		
func connectSignalsVine(vine):
	vine.body_entered.connect(_on_vine_entered)
	vine.body_exited.connect(_on_vine_exited)

func _on_vine_entered(body):
	vine_entered = true

func _on_vine_exited(body):
	vine_entered = false
