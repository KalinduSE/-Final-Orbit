extends Node2D

@export var repair_amount := 20.0  # health restored

func _ready():
	add_to_group("repair_kit")  # mark as friendly collectable

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.current_health += repair_amount
		body.current_health = clamp(body.current_health, 0, body.max_health)
		body.health_bar.value = body.current_health
		print("🛠 Repair Kit collected! +" + str(repair_amount) + " HP")
		queue_free()  # remove kit after collection
