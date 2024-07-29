extends Node2D

@onready var jogador = $Jogador as CharacterBody2D
@onready var camera = $Camera as Camera2D
@onready var control = $HUD/Control
@onready var caminho_bloqueado = $Plataformas/caminho_Bloqueado
@onready var controles = $Controles


# Called when the node enters the scene tree for the first time.
func _ready():
	jogador.follow_camera(camera)
	jogador.player_has_died.connect(reload_game)
	control.time_is_up.connect(reload_game)
	controles.visible = Global.mostrarcontroles

func check_caminho():
	if Global.caixas_quebradas > 6:
		caminho_bloqueado.visible = true
	else:
		caminho_bloqueado.visible = false


func reload_game():
	Global.game_over()

func _on_timer_timeout():
	check_caminho()
