extends TextureProgressBar

@export var player : CharacterBody2D

func _ready():
	# Get reference to the Rocket
	player.health_changed.connect(_on_health_changed)
	#player.heath

	# Initialize bar values
	max_value = player.max_health
	value = player.current_health

func _on_health_changed(new_health: float):
	value = new_health
