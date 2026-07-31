extends Node

@onready var score_label: Label = null

func _ready() -> void:
	refresh_score_label()
# This function refreshes the score label by finding it in the current scene and updating its display.
func refresh_score_label() -> void:
	var root = get_tree().current_scene
	if root:
		score_label = root.get_node_or_null("CanvasLayer/Control/VBoxContainer/Score/Label")
	update_score_display()

# This function updates the score display on the score label, if it exists.
func update_score_display() -> void:
	if score_label:
		score_label.text = str(Gamestate.score)

# This function adds to the score and updates the display.
func add_score() -> void:
	Gamestate.score += 1
	update_score_display()

# This function resets the score based on the current scene and updates the display.
func reset_score() -> void:
	var scene_path := ""
	if get_tree().current_scene:
		scene_path = get_tree().current_scene.scene_file_path
	Gamestate.score = Gamestate.get_respawn_score_for_scene(scene_path)
	update_score_display()