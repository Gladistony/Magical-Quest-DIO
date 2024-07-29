extends CharacterBody2D

var dano_causado := 1

const FIREBALL = preload("res://Objetos/fire_ball.tscn")

@export var Base_move_speed := 50
@export var Boss_Final := false
@export var Base_HP := 3

@onready var sprite = $sprite
@onready var anim = $anim
@onready var fireball_spawn = $fireball_spawn
@onready var ground_detector = $ground_detector
@onready var player_detector = $player_detector

enum EnemyState {PATROL, ATTACK, HURT}
var current_state = EnemyState.PATROL
@export var target : CharacterBody2D

var health_poits
var direction := 1

func _ready():
	health_poits = Base_HP

func move_speed():
	var porcent = int(health_poits*100/Base_HP)
	if porcent > 50:
		player_detector.target_position = Vector2(50,0)
		return Base_move_speed
	elif porcent > 10:
		player_detector.target_position = Vector2(100,0)
		return Base_move_speed * 2
	else:
		player_detector.target_position = Vector2.ZERO
		return Base_move_speed * 3.5

func _physics_process(delta):
	match(current_state):
		EnemyState.PATROL : patrol_stade()
		EnemyState.ATTACK : attack_stade()

func flip_enemy():
	direction *= -1
	sprite.scale.x *= -1
	player_detector.scale.x *= -1
	fireball_spawn.position.x *= -1

func spawn_fireball():
	var new_fire = FIREBALL.instantiate()
	if sign(fireball_spawn.position.x) == 1:
		new_fire.set_direction(1)
	else:
		new_fire.set_direction(-1)
	add_sibling(new_fire)
	new_fire.global_position = fireball_spawn.global_position

func patrol_stade():
	anim.play("running")
	if is_on_wall():
		flip_enemy()
	if not ground_detector.is_colliding():
		flip_enemy()
	velocity.x = move_speed() * direction 
	if player_detector.is_colliding():
		_change_stade(EnemyState.ATTACK)
	move_and_slide()

func attack_stade():
	anim.play("shooting")
	if not player_detector.is_colliding():
		_change_stade(EnemyState.PATROL)

func _change_stade(state):
	current_state = state

func hurt_stade():
	anim.play("hurt")
	await get_tree().create_timer(0.3).timeout
	_change_stade(EnemyState.PATROL)
	if health_poits > 0:
		health_poits -= 1
	else:
		if Boss_Final:
			await get_tree().create_timer(0.5).timeout
			get_tree().change_scene_to_file("res://Telas/vitoria.tscn")
		else:
			queue_free()

func _on_hitbox_body_entered(body):
	_change_stade(EnemyState.HURT)
	hurt_stade()
