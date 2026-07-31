extends Node

var score: int = 0
var level: int = 1
var level_2_checkpoint_score: int = 0
var has_level_2_checkpoint: bool = false


# Reset the game state to its initial values
func reset():
    score = 0
    level = 1
    level_2_checkpoint_score = 0
    has_level_2_checkpoint = false

# Store the current score as a checkpoint for level 2
func store_level_2_checkpoint() -> void:
    level_2_checkpoint_score = score
    has_level_2_checkpoint = true

# Retrieve the respawn score for a given scene path
func get_respawn_score_for_scene(scene_path: String) -> int:
    if scene_path == "res://Scenes/level_2.tscn" and has_level_2_checkpoint:
        return level_2_checkpoint_score
    return 0