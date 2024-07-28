extends Node2D

@onready var jogador = $Jogador as CharacterBody2D
@onready var camera = $Camera as Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	jogador.follow_camera(camera)
	jogador.player_has_died.connect(reload_game)


func reload_game():
	await get_tree().create_timer(1.0).timeout
	get_tree().reload_current_scene()
	Global.reset()
