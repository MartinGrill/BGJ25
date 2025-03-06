class_name Player extends CharacterBody2D

const WALK_SPEED = 6000.0
const JUMP_VELOCITY = -280.0
## Maximum speed at which the player can fall.
const TERMINAL_VELOCITY = 300
# var screen_size # Size of the game window.
var can_control : bool = true

var gravity: int = ProjectSettings.get("physics/2d/default_gravity")
@onready var platform_detector := $PlatformDetector as RayCast2D

var _double_jump_charged := false

func _ready() -> void:
	self.current_element = Element.Nothing

func _physics_process(delta: float) -> void:
	if not can_control: return
	
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
		$AnimatedSprite2D.play()
		$AnimatedSprite2D.animation = "walk"
		# See the note below about the following boolean assignment.
		$AnimatedSprite2D.flip_h = velocity.x < 0
	else:
		$AnimatedSprite2D.stop()
	
	floor_stop_on_slope = not platform_detector.is_colliding()
	move_and_slide()

func try_jump() -> void:
	if _double_jump_charged:
		_double_jump_charged = false
		velocity.x *= 2.5
	else:
		return
	velocity.y = JUMP_VELOCITY

## Element system (TODO)
enum Element { Nothing, Fire, Water, Earth, Air }
var current_element : Element

func change_element(element: Element):
	self.current_element = element
	
