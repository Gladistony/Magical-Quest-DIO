extends CharacterBody2D


const SPEED = 1000.0
const JUMP_VELOCITY = -400.0

@export var dano_causado = 1

@onready var wall_detector := $wall_detector as RayCast2D
@onready var floor_detector := $floor_detector as RayCast2D
@onready var texture := $Texture as Sprite2D
@onready var anim := $Animacao as AnimationPlayer

var direction = -1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var no_fall := false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if wall_detector.is_colliding() or (no_fall and (not floor_detector.is_colliding())):
		direction *= -1
		wall_detector.scale.x *= -1
		floor_detector.scale.x *= -1
	
	if direction == 1:
		texture.flip_h = true
	else:
		texture.flip_h = false

	velocity.x = direction * SPEED * delta
	move_and_slide()


func _on_animacao_animation_finished(anim_name):
	if anim_name == "hurt":
		Global.score += 100
		queue_free()
