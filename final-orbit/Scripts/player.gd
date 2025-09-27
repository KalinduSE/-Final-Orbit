extends CharacterBody2D

# Rocket movement speed
const SPEED := 300.0           # pixels per second
const BOOST_SPEED := 500.0     # optional faster speed when boosting

# Fuel settings
var max_fuel := 100.0
var current_fuel := 100.0
var fuel_drain_rate := 10.0    # units per second while moving

# Rocket state
var is_disabled : bool = false  # disable movement during cutscenes/rotations

func _physics_process(delta: float) -> void:
	if is_disabled:
		velocity = Vector2.ZERO
		return  # stop movement if disabled

	# --- Get player input ---
	var input_vector := Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	if input_vector.length() > 0:
		input_vector = input_vector.normalized()  # prevent faster diagonal movement

	# --- Optional Boost ---
	var current_speed := SPEED
	if Input.is_action_pressed("ui_select"):  # Shift key or custom action
		current_speed = BOOST_SPEED

	# --- Apply movement ---
	velocity = input_vector * current_speed
	move_and_slide()

	# --- Fuel drain while moving ---
	if input_vector.length() > 0:
		current_fuel -= fuel_drain_rate * delta
		current_fuel = clamp(current_fuel, 0, max_fuel)  # prevent negative fuel
