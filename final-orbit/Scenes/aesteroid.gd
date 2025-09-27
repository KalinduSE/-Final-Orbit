extends Area2D

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.name == "player":
		body.take_damage(20)  # Reduce health by 20 (adjust as needed)
		queue_free()  # Optional: destroy asteroid after collision
