class_name Player extends CharacterBody2D

const WALK_SPEED = 6000.0
const JUMP_VELOCITY = -280.0
## Maximum speed at which the player can fall.
const TERMINAL_VELOCITY = 300
# var screen_size # Size of the game window.

var gravity: int = ProjectSettings.get("physics/2d/default_gravity")
@onready var platform_detector := $PlatformDetector as RayCast2D
@onready var sprite := $AnimatedSprite2D

var _double_jump_charged := false

func _physics_process(delta: float) -> void:
	if is_on_floor():
		_double_jump_charged = true
	if Input.is_action_just_pressed("jump"):
		try_jump()
	elif Input.is_action_just_released("jump") and velocity.y < 0.0:
		# The player let go of jump early, reduce vertical momentum.
		velocity.y *= 0.6
	# Fall.
	velocity.y = minf(TERMINAL_VELOCITY, velocity.y + gravity * delta)

	var direction := Input.get_axis("move_left", "move_right") * WALK_SPEED
	velocity.x = direction * delta
	
	if velocity.x != 0:
		sprite.play()
		sprite.animation = "walk"
		# See the note below about the following boolean assignment.
		sprite.flip_h = velocity.x < 0
	else:
		sprite.stop()
	
	floor_stop_on_slope = not platform_detector.is_colliding()
	move_and_slide()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("first_ability"):
		print("E pressed")
	if Input.is_action_just_pressed("second_ability"):
		print("F pressed")
	if Input.is_action_pressed("change_water"): change_element(Element.Water)
	if Input.is_action_pressed("change_fire"): change_element(Element.Fire)
	if Input.is_action_pressed("change_air"): change_element(Element.Air)
	if Input.is_action_pressed("change_earth"): change_element(Element.Earth)

func try_jump() -> void:
	if _double_jump_charged:
		_double_jump_charged = false
		velocity.x *= 2.5
	else:
		return
	velocity.y = JUMP_VELOCITY

## Element system (TODO)
enum Element { Neutral, Water, Fire, Air, Earth }
var current_element : Element

func change_element(element: Element):
	self.current_element = element
	match element:
		Element.Neutral: load("res://entities/player/resources/player_neutral.tres")
		Element.Water: sprite.sprite_frames = load("res://entities/player/resources/player_blue.tres")
		Element.Fire: sprite.sprite_frames = load("res://entities/player/resources/player_red.tres")
		Element.Air: sprite.sprite_frames = load("res://entities/player/resources/player_grey.tres")
		Element.Earth: sprite.sprite_frames = load("res://entities/player/resources/player_green.tres")

func _ready() -> void:
		change_element(Element.Neutral)
		
func _process(delta: float) -> void:
