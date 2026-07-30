extends Area2D

@onready var animation_player = $AnimationPlayer
var _collected: bool = false

func _ready() -> void:
	visible = true
	monitoring = true
	if animation_player and animation_player.has_animation("RESET"):
		animation_player.play("RESET")

func _on_body_entered(body: Node2D) -> void:
	if _collected:
		return
	if body is Node2D and body.is_in_group("Player"):
		_collected = true
		visible = false
		monitoring = false
		if animation_player and animation_player.has_animation("pickup"):
			animation_player.play("pickup")

		var game_manager = get_tree().current_scene.get_node_or_null("GameManager")
		if game_manager and game_manager.has_method("add_score"):
			game_manager.add_score()
		else:
			Gamestate.score += 1

func reset_coin() -> void:
	_collected = false
	visible = true
	monitoring = true
	if animation_player and animation_player.has_animation("RESET"):
		animation_player.play("RESET")
