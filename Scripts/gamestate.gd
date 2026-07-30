extends Node

var score: int = 0
var level: int = 1
var level_2_checkpoint_score: int = 0
var has_level_2_checkpoint: bool = false



func reset():
    score = 0
    level = 1
    level_2_checkpoint_score = 0
    has_level_2_checkpoint = false


func store_level_2_checkpoint() -> void:
    level_2_checkpoint_score = score
    has_level_2_checkpoint = true


func get_respawn_score_for_scene(scene_path: String) -> int:
    if scene_path == "res://Scenes/level_2.tscn" and has_level_2_checkpoint:
        return level_2_checkpoint_score
    return 0