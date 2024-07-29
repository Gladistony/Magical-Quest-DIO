extends CharacterBody2D

const SPEED_BASE = 5000
var direction = -1
@onready var wall_detector = $wall_detector
@onready var sprite = $sprite


var dano_causado := 1

func atual_speed():
	return SPEED_BASE

func _physics_process(delta):
	if wall_detector.is_colliding():
		direction *= -1
		wall_detector.scale.x *= -1
	
	if direction == 1:
		velocity.x = atual_speed() * delta
		sprite.flip_h = true
	else:
		velocity.x = -1 * atual_speed() * delta
		sprite.flip_h = false
	
	move_and_slide()
