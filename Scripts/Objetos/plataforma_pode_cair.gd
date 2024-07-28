extends AnimatableBody2D

@onready var anim := $anim as AnimationPlayer
@onready var respaw_time := $respaw_time as Timer
@onready var respaw_position := global_position

@export var reset_time := 3.0

var velocity := Vector2.ZERO
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_triggered := false

func _physics_process(delta):
	velocity.y += gravity * delta
	position += velocity * delta

func _ready():
	set_physics_process(false)

func has_collided_with(collision : KinematicCollision2D , collider : CharacterBody2D):
	if !is_triggered:
		is_triggered = true
		anim.play("shake")
		velocity = Vector2.ZERO
		
func _on_anim_animation_finished(anim_name):
	set_physics_process(true)
	respaw_time.start(reset_time)


func _on_respaw_time_timeout():
	set_physics_process(false)
	global_position = respaw_position
	if is_triggered:
		var spawn_tween = create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN_OUT)
		spawn_tween.tween_property($texture, "scale", Vector2(1,1), 0.2).from(Vector2.ZERO)
		
	is_triggered = false
