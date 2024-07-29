extends CharacterBody2D

var dano_causado := 2
var move_speed := 50
var direction := 1
@onready var sprite = $sprite

func _process(delta):
	position.x += move_speed * direction * delta

func set_direction(dir):
	direction = dir
	if dir < 0:
		$sprite.flip_h = true
	else:
		$sprite.flip_h = false
