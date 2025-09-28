extends CharacterBody2D

# --- Rocket Movement ---
const SPEED := 300.0           # normal speed
const BOOST_SPEED := 500.0     # boost speed

# --- Fuel & Health ---
var max_fuel := 100.0
var current_fuel := 100.0
var fuel_drain_rate := 5.0      # fuel per second while moving
var max_health := 100
var current_health := 100

# --- References to UI bars ---
@onready var health_bar = $CanvasLayer/HealthBar      # TextureProgressBar
@onready var fuel_bar = $CanvasLayer/FuelBar          # TextureProgressBar

# --- Rocket State ---
var is_disabled : bool = false   # disables movement during cutscenes

signal health_changed

func _physics_process(_delta: float) -> void:
	if is_disabled:
		velocity = Vector2.ZERO
		return  # stop movement if disabled

	# --- Player input ---
	var input_vector := Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	if input_vector.length() > 0:
		input_vector = input_vector.normalized()

	# --- Boost speed ---
	var current_speed := SPEED
	if Input.is_action_pressed("ui_select"):
		current_speed = BOOST_SPEED

	# --- Move the rocket ---
	velocity = input_vector * current_speed
	move_and_slide()

	# --- Fuel drain ---
	if input_vector.length() > 0:
		current_fuel -= fuel_drain_rate * _delta
		current_fuel = clamp(current_fuel, 0, max_fuel)
		fuel_bar.value = current_fuel

	# --- Check fuel depletion ---
	if current_fuel <= 0:
		die()

func take_damage(amount: float) -> void:
	current_health -= amount
	current_health = clamp(current_health, 0, max_health)
	health_bar.value = current_health
	if current_health <= 0:
		die()

func die() -> void:
	print("🚀 Game Over! Rocket destroyed or fuel ran out")
	is_disabled = true
	velocity = Vector2.ZERO
	# TODO: Switch to Game Over scene or show message
