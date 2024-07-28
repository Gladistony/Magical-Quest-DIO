extends Area2D

@onready var spikes = $spikes
@onready var collision_shape_2d = $CollisionShape2D

func _ready():
	collision_shape_2d.shape.size = spikes.get_rect().size

func _on_body_entered(body):
	if body.name == "Jogador" && body.has_method("take_damage"):
		body.take_damage(1, Vector2(0, -250))
