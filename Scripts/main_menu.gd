extends Control


# Exit game Launcher when exit is pressed
func _on_exit_pressed() -> void:
	get_tree().quit()

# Start game when start is pressed
func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")
