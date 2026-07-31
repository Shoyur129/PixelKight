extends Area2D


func _on_body_entered(body: Node2D) -> void:
	var current_scene = get_tree().current_scene
	if current_scene == null:
		return

	var is_player = body.is_in_group("player") or body.is_in_group("Player")
	if not is_player:
		return
	# Check the current scene and change to the next scene accordingly
	if current_scene.scene_file_path == "res://Scenes/level_1.tscn":
		Gamestate.store_level_2_checkpoint()
		get_tree().change_scene_to_file("res://Scenes/level_2.tscn")
		
	# Check if the current scene is level_2 and change to end scene
	elif current_scene.scene_file_path == "res://Scenes/level_2.tscn":
		get_tree().change_scene_to_file("res://Scenes/end.tscn")
