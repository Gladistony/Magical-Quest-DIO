extends Area2D

@export var coin_valor := 1
@export_range(0,1,0.01) var cor_modulo_r := 1.0
@export_range(0,1,0.01) var cor_modulo_g := 1.0
@export_range(0,1,0.01) var cor_modulo_b := 1.0
@export_range(0,1,0.01) var cor_modulo_a := 1.0
@onready var audio_stream_player = $AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.modulate = Color(cor_modulo_r, cor_modulo_g, cor_modulo_b, cor_modulo_a)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_body_entered(_body):
	$AnimatedSprite2D.play("Coletada")
	await $CollisionShape2D.call_deferred("queue_free")
	audio_stream_player.play()
	Global.coins += coin_valor
	Global.score += 5*coin_valor


func _on_animated_sprite_2d_animation_finished():
	queue_free()
