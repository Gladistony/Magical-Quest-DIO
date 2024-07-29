extends EnemyBase

@onready var spaw_enemy = $"../spaw_enemy"

func _ready():
	spawn_instance = preload("res://Objetos/cherry.tscn")
	spawn_instance_position = spaw_enemy
	can_spawm = true
	anim.animation_finished.connect(kill_air_enemy)
