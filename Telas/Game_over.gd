extends Control



func _on_reiniciar_pressed():
	get_tree().change_scene_to_file("res://Fases/World-1.tscn")


func _on_voltar_inicio_pressed():
	get_tree().change_scene_to_file("res://Telas/Main.tscn")


func _on_sair_pressed():
	get_tree().quit()
