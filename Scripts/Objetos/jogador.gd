extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jump = false
var direction = 0

var knockback_vector = Vector2.ZERO

@onready var animation := $Animacao as AnimatedSprite2D
@onready var remote_camera = $remote_Camera
@onready var ray_right = $Ray_Right as RayCast2D
@onready var ray_left = $Ray_Left as RayCast2D

signal player_has_died()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		is_jump = true
	elif  is_on_floor():
		is_jump = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x = direction * SPEED
		animation.scale.x = direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if knockback_vector != Vector2.ZERO:
		velocity = knockback_vector
	
	_set_stade()
	move_and_slide()
	
	for platforms in get_slide_collision_count():
		var collision = get_slide_collision(platforms)
		if collision.get_collider().has_method("has_collided_with"):
			collision.get_collider().has_collided_with(collision, self)


func _on_hurt_box_body_entered(body):
	if ray_left.is_colliding():
		take_damage(body.dano_causado,Vector2(200,-200))
	elif ray_right.is_colliding():
		take_damage(body.dano_causado,Vector2(-200,-200))

func take_damage(dano := 1, knokback_force := Vector2.ZERO, duration := 0.25):
	if Global.life > dano:
		Global.life -= dano
	else:
		Global.life = 0
		queue_free()
		emit_signal("player_has_died")
		
	if knokback_force != Vector2.ZERO:
		knockback_vector = knokback_force
		var knockback_tween = get_tree().create_tween().parallel()
		knockback_tween.tween_property(self, "knockback_vector", Vector2.ZERO, duration)
		animation.modulate = Color(1,0,0,1)
		knockback_tween.tween_property(animation, "modulate", Color(1,1,1,1), duration)

func follow_camera(camera):
	var camera_path = camera.get_path()
	remote_camera.remote_path = camera_path

func _set_stade():
	var stade = "Idle"
	if !is_on_floor():
		stade = "Jump"
	elif direction != 0:
		stade = "Run"
	
	if animation.name != stade:
		animation.play(stade)


func _on_head_collide_body_entered(body):
	if body.has_method("sprites_Pedacos"):
		if body.hitpoint < 1:
			body.sprites_Pedacos()
		else:
			body.animation_player.play("hit")
			body.hitpoint -= 1
			body.creat_coin()
		
