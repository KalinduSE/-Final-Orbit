extends Node2D

@onready var player: CharacterBody2D = $player
@onready var input_blocker =$UI/InputBlocker
@onready var choice_screen = $UI/ChoiceScreen
@onready var dialogue_label: Label =$UI/DialogueLabel
@onready var timer_label: Label = $UI/TimerLabel
@onready var decision_timer: Timer =$UI/DecisionTimer

var time_left = 10
var choice_made = false

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

	choice_screen.get_node("%Save your friend").connect("pressed", Callable(self, "_on_save_your_friend_pressed"))
	choice_screen.get_node("%Save the Earth").connect("pressed", Callable(self, "_on_save_the_earth_pressed"))

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
	choice_made = true
	decision_timer.stop()
	print("Save your friend pressed")
	# Add your save friend logic here

func _on_save_the_earth_pressed() -> void:
	choice_made = true
	decision_timer.stop()
	print("Save the Earth pressed")
	# Add your save the Earth logic here

func _fail_game() -> void:
	print("Game Over logic triggered.")
	# Add your game-over handling here (e.g., go to game over scene)
