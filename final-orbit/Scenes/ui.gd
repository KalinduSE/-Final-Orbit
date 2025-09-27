extends CanvasLayer

@onready var dialogue_label = $DialogueLabel

var dialogues = [
	"System booting up...",
	"Warning: Engine failure detected!",
    "Attempting to stabilize orbit..."
]

func _ready():
	show_dialogues()

func show_dialogues() -> void:
	await show_dialogue_line(dialogues[0], 3.0)
	await show_dialogue_line(dialogues[1], 3.0)
	await show_dialogue_line(dialogues[2], 4.0)

func show_dialogue_line(text: String, duration: float) -> void:
	dialogue_label.text = text
	await get_tree().create_timer(duration).timeout
	dialogue_label.text = ""  # Clear after showing
