extends Node2D

@onready var player: CharacterBody2D = $player
@onready var input_blocker = $UI/InputBlocker
@onready var choice_screen = $UI/ChoiceScreen
@onready var dialogue_label: Label = $UI/DialogueLabel
@onready var timer_label: Label = $UI/TimerLabel
@onready var decision_timer: Timer = $UI/DecisionTimer

@onready var fuel_bar = $CanvasLayer/FuelBar
@onready var health_bar = $CanvasLayer/HealthBar

# Fuel & health
var max_fuel = 100
var max_health = 100
var current_fuel = 100
var current_health = 100

var turning_back = false

# Timer / choice
var time_left = 10
var choice_made = false

# Turning / rotation
var fuel_drain_duration = 2.0
var fuel_drain_total = max_fuel * 0.15
var fuel_drain_timer = 0.0
var rotating_back = false
var target_angle = 0.0
var rotation_done = false

func _ready() -> void:
	player.is_disabled = true
	choice_screen.visible = false
	timer_label.visible = false

	await get_tree().create_timer(10.0).timeout

	player.is_disabled = false
	choice_screen.visible = true
	timer_label.visible = true
	time_left = 10
	timer_label.text = str(time_left)
	choice_made = false

	decision_timer.wait_time = 1.0
	decision_timer.one_shot = false
	decision_timer.autostart = false
	decision_timer.connect("timeout", Callable(self, "_on_timer_tick"))
	decision_timer.start()

	choice_screen.get_node("SaveYourFriend").connect("pressed", Callable(self, "_on_save_your_friend_pressed"))
	choice_screen.get_node("SaveTheEarth").connect("pressed", Callable(self, "_on_save_the_earth_pressed"))

	fuel_bar.max_value = max_fuel
	health_bar.max_value = max_health

	fuel_bar.value = current_fuel
	health_bar.value = current_health


func _on_timer_tick() -> void:
	time_left -= 1
	timer_label.text = str(time_left)

	if time_left <= 0 and not choice_made:
		decision_timer.stop()
		choice_screen.visible = false
		timer_label.visible = false
		print("Time's up! Game Over.")
		_fail_game()


func _on_save_your_friend_pressed() -> void:
	if rotation_done:
		return  # prevent multiple rotations

	choice_made = true
	fuel_drain_timer = 0.0
	print("Save your friend pressed")

	# Set target rotation 180° from current rotation
	target_angle = player.rotation + deg_to_rad(180)
	turning_back = true
	rotating_back = true
	rotation_done = true  # ensures rotation happens only once

	# Reduce fuel by half immediately
	current_fuel /= 2
	fuel_bar.value = current_fuel
	print("Save your friend pressed - ship will rotate 180° and fuel reduced.")


func _on_save_the_earth_pressed() -> void:
	choice_made = true
	decision_timer.stop()
	print("Save the Earth pressed")
	# Add your save the Earth logic here


func _fail_game() -> void:
	print("Game Over logic triggered.")
	# Add your game-over handling here (e.g., go to game over scene)


func _process(delta):
	if turning_back:
		fuel_drain_timer += delta
		var progress = fuel_drain_timer / fuel_drain_duration
		if progress >= 1.0:
			progress = 1.0
			turning_back = false

		# Rotate player smoothly (0° to 90°)
		$player.rotation = deg_to_rad(180) * progress

		# Reduce fuel slowly up to 15%
		current_fuel = max_fuel - fuel_drain_total * progress
		fuel_bar.value = current_fuel
