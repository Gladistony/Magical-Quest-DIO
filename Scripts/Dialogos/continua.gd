extends Node2D

@onready var textura = $Textura
@onready var area_intro = $Area_Intro

const lines : Array[String] = [
	'Para o caminho liberar',
	"Todas as caixas vermelhas",
	"voce deve quebrar"
]

func _unhandled_input(event):
	if area_intro.get_overlapping_bodies().size() > 0:
		textura.show()
		if event.is_action_pressed("interact") && !DialogManager.is_message_active:
			textura.hide()
			DialogManager.start_message(global_position, lines)
	else:
		textura.hide()
		if DialogManager.dialog_box != null:
			DialogManager.dialog_box.queue_free()
			DialogManager.is_message_active = false
