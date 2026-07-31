extends Control


# quit game at the end
func _on_exit_pressed() -> void:
	get_tree().quit()
#reutrn to main menu at the end
func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

