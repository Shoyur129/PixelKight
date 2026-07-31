extends Node2D

@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var animated_sprite = $AnimatedSprite2D

const SPEED = 60.0

var direction = 1

#control the slime's movement and animation
func _process(delta):
	if ray_cast_right.is_colliding():
		direction = -1 #flip direction to left if colliding with right raycast
		animated_sprite.flip_h = true
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
	position.x += direction * SPEED * delta
