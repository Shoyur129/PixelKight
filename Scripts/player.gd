extends CharacterBody2D

var can_slash: bool = true
@export var weapon_damage: float = 1.0
@export var slash_time: float = 0.2
@export var slash_return_time: float = 0.5

@onready var animated_sprite = $AnimatedSprite2D
var _spawn_position: Vector2

const SPEED = 115.0
const JUMP_VELOCITY = -190.0


func _ready() -> void:
	_spawn_position = global_position
	if not is_in_group("Player"):
		add_to_group("Player")


func respawn() -> void:
	global_position = _spawn_position
	velocity = Vector2.ZERO
	set_physics_process(true)
	if animated_sprite and animated_sprite.sprite_frames and animated_sprite.sprite_frames.has_animation("Idle"):
		animated_sprite.play("Idle")

	var game_manager = get_tree().current_scene.get_node_or_null("GameManager")
	# Reset the score when the player respawns
	if game_manager and game_manager.has_method("reset_score"):
		game_manager.reset_score()
	
	var coins = get_tree().current_scene.get_node_or_null("Coins")
	# Reset all coins when the player respawns
	if coins:
		for coin in coins.get_children():
			if coin is Node and coin.has_method("reset_coin"):
				coin.reset_coin()


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("Left", "Right")

	# Flip the sprite based on the direction of movement and the sword slash direction
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	# Play jump while airborne, otherwise use idle/run on ground.
	if not is_on_floor():
		animated_sprite.play("Jump")
	elif direction == 0:
		animated_sprite.play("Idle")
	else:
		animated_sprite.play("Run")

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
