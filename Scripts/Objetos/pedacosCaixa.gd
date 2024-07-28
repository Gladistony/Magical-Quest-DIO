extends RigidBody2D


func _on_notifier_screen_exited():
	queue_free()

func _on_timer_timeout():
	queue_free()
