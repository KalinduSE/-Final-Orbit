extends StaticBody2D

@onready var collision = $CollisionShape2D

func _ready():
	await get_tree().create_timer(20.0).timeout
	collision.queue_free()
