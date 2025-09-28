extends CharacterBody2D

# --- Rocket Movement ---
const SPEED := 300.0
const BOOST_SPEED := 500.0

# --- Fuel & Health ---
var max_fuel := 100.0
var current_fuel := 100.0
var fuel_drain_rate := 5.0

var max_health := 100
var current_health := 100

# --- UI References ---
@onready var health_bar = $CanvasLayer/HealthBar   # TextureProgressBar
@onready var fuel_bar = $CanvasLayer/FuelBar       # TextureProgressBar

# --- Rocket State ---
var is_disabled : bool = false

func _ready() -> void:
	%GameOver.visible = false
	

func _physics_process(_delta: float) -> void:
	if is_disabled:
		velocity = Vector2.ZERO
		return

	# --- Movement Input ---
	var input_vector := Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	if input_vector.length() > 0:
		input_vector = input_vector.normalized()

	var current_speed := SPEED
	if Input.is_action_pressed("ui_select"):  # Boost
		current_speed = BOOST_SPEED

	# Move rocket
	velocity = input_vector * current_speed
	move_and_slide()

	# --- Fuel drain ---
	if input_vector.length() > 0:
		current_fuel -= fuel_drain_rate * _delta
		current_fuel = clamp(current_fuel, 0, max_fuel)
		fuel_bar.value = current_fuel

	# --- Check fuel depletion ---
	if current_fuel <= 0:
		game_over("Fuel depleted!")

func take_damage(amount: float) -> void:
	current_health -= amount
	current_health = clamp(current_health, 0, max_health)
	health_bar.value = current_health

	if current_health <= 0:
		game_over("Health depleted!")

# --- Game Over Function ---
func game_over(reason: String) -> void:
	if is_disabled:
		return
	is_disabled = true
	velocity = Vector2.ZERO

	%GameOver.visible = true
