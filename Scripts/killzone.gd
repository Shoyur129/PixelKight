extends Area2D

@onready var timer = $Timer
var _dead_player: Node = null

func _ready() -> void:
	# Ensure killzone works even if the signal was not connected in the scene.
	if not body_entered.is_connected(_on_body_entered):
		body_entered.connect(_on_body_entered)
	# Avoid repeated timeout calls causing multiple respawns.
	timer.one_shot = true

func _on_body_entered(body: Node) -> void:
	if _dead_player != null:
		return

	if not body.is_in_group("Player") and not (body is CharacterBody2D):
		return

	print("player has died")
	Engine.time_scale = 0.5

	# Play the player's death animation if available
	if body.has_node("AnimatedSprite2D"):
		var sprite = body.get_node("AnimatedSprite2D")
		var frames = sprite.sprite_frames
		if frames and frames.has_animation("Die"):
			sprite.play("Die")
		elif frames and frames.has_animation("Death"):
			sprite.play("Death")

	# Stop player movement/physics so animation can play cleanly
	if body is CharacterBody2D:
		body.velocity = Vector2.ZERO
		body.set_physics_process(false)

	# Remember which player died so we can respawn them after the timer
	_dead_player = body

	timer.start()


func _on_timer_timeout() -> void:
	timer.stop()
	Engine.time_scale = 1.0
	# If we still have a valid dead player instance, call its respawn method.
	if _dead_player and is_instance_valid(_dead_player) and _dead_player.has_method("respawn"):
		_dead_player.respawn()
	else:
		# Fallback: try to find any player in the scene tree and respawn it
		var players = get_tree().get_nodes_in_group("Player")
		if players.size() > 0:
			var p = players[0]
			if p and p.has_method("respawn"):
				p.respawn()

	_dead_player = null
 

