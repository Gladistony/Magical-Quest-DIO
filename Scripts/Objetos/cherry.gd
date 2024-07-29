extends EnemyBase

func _physics_process(delta):
	gravidade(delta)
	movimento(delta)

func _ready():
	anim.animation_finished.connect(kill_air_enemy)
	enemy_score = 50

func _on_auto_excluir_screen_exited():
	queue_free()
