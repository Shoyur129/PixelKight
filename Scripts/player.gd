extends CharacterBody2D

var can_slash: bool = true
@export var weapon_damage: float = 1.0
@export var slash_time: float = 0.2
@export var slash_return_time: float = 0.5

@onready var animated_sprite = $AnimatedSprite2D
@onready var sword = $Sword

const SPEED = 175.0
const JUMP_VELOCITY = -250.0


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
		sword.position.x = abs(sword.position.x)
	elif direction < 0:
		animated_sprite.flip_h = true
		sword.position.x = -abs(sword.position.x)

	# Play animations
	if direction == 0:
		animated_sprite.play("Idle")
	else:
		animated_sprite.play("Run")

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
