extends Node2D

@export var scroll_speed: float = 50.0
var screen_height: float = 1080
var t : float
var mod : float = 0


func _ready() -> void:
	mod = randf_range(0.1,1.0)


func _process(delta):
	t += delta
	position.x = scroll_speed * sin(t) * mod
	rotation_degrees = sin(t + scroll_speed)
	position.y += scroll_speed * delta  * mod
	if position.y >= screen_height:
		position.y -= screen_height * 2  * mod  # loop back 
