extends EnemyBase

func _ready():
	wall_detector = $wall_detector 
	floor_detector = $floor_detector
	texture = $Texture
	anim.animation_finished.connect(kill_ground_enemy)

func _physics_process(delta):
	gravidade(delta)
	movimento(delta)
	flip_direction()
