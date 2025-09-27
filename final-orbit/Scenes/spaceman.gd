extends AnimatedSprite2D

const SPEED = 200.0
const ROTATION_SPEED = 5.0  # radians per second

var started := false

func _ready() -> void:
	# Wait 10 seconds, then start everything
	await get_tree().create_timer(10).timeout
	play("run")  # start animation only after delay
	started = true

func _process(delta: float) -> void:
	if started:
		# Move left
		position.x -= SPEED * delta
		# Rotate
		rotation += ROTATION_SPEED * delta
