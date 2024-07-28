extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_body_entered(_body):
	$AnimatedSprite2D.play("Coletada")
	await $CollisionShape2D.call_deferred("queue_free")
	Global.coins += 1
	Global.score += 10


func _on_animated_sprite_2d_animation_finished():
	queue_free()
