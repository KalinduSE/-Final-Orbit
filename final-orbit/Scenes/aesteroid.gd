extends Area2D

@export var damage_amount: float = 2.0     # health decrease per collision
@export var apply_once: bool = true        # only apply damage once per rocket

var already_damaged_bodies := []

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body):
	if body.is_in_group("player"):
		if apply_once and body in already_damaged_bodies:
			return
		body.take_damage(damage_amount)
		if apply_once:
			already_damaged_bodies.append(body)
		print("Barrier hit! Rocket lost %s health" % damage_amount)
		

func _on_body_exited(body):
	if body in already_damaged_bodies:
		already_damaged_bodies.erase(body)
		queue_free()
# Barriers are static, no movement or rotation
func _process(_delta: float) -> void:
	pass
