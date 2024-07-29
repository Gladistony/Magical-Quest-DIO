extends CharacterBody2D
class_name EnemyBase

const SPEED = 1000.0
const JUMP_VELOCITY = -400.0
@export var enemy_score := 100

@export var dano_causado = 1

@onready var anim := $Animacao

var wall_detector
var floor_detector
var texture

var direction = -1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var no_fall := false

var can_spawm = false
var spawn_instance : PackedScene = null
var spawn_instance_position

	
func gravidade(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		
func movimento(delta):
	velocity.x = direction * SPEED * delta
	move_and_slide()

func flip_direction():
	if wall_detector.is_colliding() or (no_fall and (not floor_detector.is_colliding())):
		direction *= -1
		wall_detector.scale.x *= -1
		floor_detector.scale.x *= -1
	
	if direction == 1:
		texture.flip_h = true
	else:
		texture.flip_h = false


func kill_ground_enemy(anim_name: StringName) -> void:
	kill_and_score()

func kill_air_enemy():
	kill_and_score()

func kill_and_score():
	Global.score += enemy_score
	if can_spawm:
		spawn_new_enemy()
		get_parent().queue_free()
	else:
		queue_free()

func spawn_new_enemy():
	var instance_scene = spawn_instance.instantiate()
	get_tree().root.add_child(instance_scene)
	instance_scene.global_position = spawn_instance_position.global_position
	
