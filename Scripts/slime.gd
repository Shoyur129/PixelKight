extends CharacterBody2D

var health: float = 3.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()

func take_damage(weapon_damage: float):
	$AnimatedSprite2D.play("hit")
	health -= weapon_damage
	if health <= 0:
		queue_free()