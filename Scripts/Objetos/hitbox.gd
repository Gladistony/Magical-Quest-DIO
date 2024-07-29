extends Area2D


func _on_body_entered(body):
	if body.name == "Jogador":
		body.velocity.y = body.JUMP_VELOCITY
		get_parent().anim.play("hurt")
