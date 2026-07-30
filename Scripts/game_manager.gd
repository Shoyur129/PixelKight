extends Node

@onready var score_label: Label = null

func _ready() -> void:
	refresh_score_label()

func refresh_score_label() -> void:
	var root = get_tree().current_scene
	if root:
		score_label = root.get_node_or_null("CanvasLayer/Control/VBoxContainer/Score/Label")
	update_score_display()

func update_score_display() -> void:
	if score_label:
		score_label.text = str(Gamestate.score)

func add_score() -> void:
	Gamestate.score += 1
	update_score_display()

func reset_score() -> void:
	Gamestate.score = 0
	update_score_display()