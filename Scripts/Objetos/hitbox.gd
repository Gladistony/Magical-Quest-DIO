extends Area2D


func _on_body_entered(body):
	if body.name == "Jogador":
		body.velocity.y = body.JUMP_VELOCITY
		owner.anim.play("hurt")
