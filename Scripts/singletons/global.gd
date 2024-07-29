extends Node

var coins := 0
var score := 0
var life := 5
var caixas_quebradas := 0
var mostrarcontroles := false
var minutos := 0
var segundos := 0

func reset():
	coins = 0
	score = 0
	life = 5
	caixas_quebradas = 0

func game_over():
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://Telas/Game_over.tscn")
	Global.reset()
