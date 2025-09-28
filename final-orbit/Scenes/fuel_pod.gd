extends Node2D

@export var refill_amount := 20.0  # fuel restored

func _ready():
	add_to_group("fuel_pod")  # mark as friendly collectable

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.current_fuel += refill_amount
		body.current_fuel = clamp(body.current_fuel, 0, body.max_fuel)
		body.fuel_bar.value = body.current_fuel
		print("⛽ Fuel Pod collected! +" + str(refill_amount))
		queue_free()  # remove pod after collection
