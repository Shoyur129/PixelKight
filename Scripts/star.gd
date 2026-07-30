extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body is Node2D and body.is_in_group("Player"):
		get_tree().change_scene_to_file("res://Scenes/end.tscn")
