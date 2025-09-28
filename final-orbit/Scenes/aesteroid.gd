extends Node2D

@export var drift_speed: float = 50.0
@export var rotation_speed: float = 20.0

@export var damage_amount: float = 20.0
@export var damage_duration: float = 1.0

var damaging = false
var damage_timer = 0.0
var target_body = null
var screen_height = 1080

	
func _on_body_entered(body):
	if body.is_in_group("player"):
		damaging = true
		damage_timer = 0.0
		#target_body = body
		body.take_damage(damage_amount)
		queue_free()
	
	
func _on_body_exited(body):
	if body == target_body:
		damaging = false
		target_body = null
		
	
func _process(delta):
	# Drift downward
	position.y += drift_speed * delta

	# Rotate smoothly
	rotation_degrees += rotation_speed * delta

	# Remove if out of screen
	if position.y > screen_height + 50:
		queue_free()

	## Smooth damage
	#if damaging and target_body:
		#damage_timer += delta
		#var progress = damage_timer / damage_duration
		#if progress > 1.0:
			#progress = 1.0
			#damaging = false
		#target_body.current_health = max(target_body.current_health - damage_amount * delta / damage_duration, 0)
		#target_body.health_bar.value = target_body.current_health
		#
		#
		#if target_body.current_health <= 0:
			#target_body._fail_game()
