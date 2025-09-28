extends Node2D

@onready var menu_music = $AudioStreamPlayer
@onready var button_sfx = $AudioStreamPlayer2
@onready var menu_sfx = $AudioStreamPlayer3


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		menu_music.play()

	
	 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	pass
func _on_button_pressed() -> void:
	menu_sfx.play()
	get_tree().change_scene_to_file("res://Scenes/space.tscn")
	
	
func _on_button_2_pressed() -> void:
	menu_sfx.play()
	get_tree().quit()


func _on_button_mouse_entered() -> void:
	button_sfx.play()


func _on_button_2_mouse_entered() -> void:
	button_sfx.play()
