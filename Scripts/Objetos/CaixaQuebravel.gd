extends CharacterBody2D

const box_pieces = preload("res://Objetos/pedacosCaixa.tscn")
const coin_instance = preload("res://Objetos/coin_rigid.tscn")

@onready var animation_player := $anim as AnimationPlayer
@onready var spawn := $spawn_coin as Marker2D

@export var pieces: PackedStringArray
@export var hitpoint := 3

var impulse := 100

func sprites_Pedacos():
	for piece in pieces.size():
		var piece_instance = box_pieces.instantiate()
		get_parent().add_child(piece_instance)
		piece_instance.get_node("texturas").texture = load(pieces[piece])
		piece_instance.global_position = global_position
		piece_instance.apply_impulse(Vector2(randi_range(-impulse,impulse),randi_range(-impulse, -impulse*2)))
	queue_free()	

func creat_coin():
	var coin = coin_instance.instantiate()
	get_parent().call_deferred("add_child", coin)
	coin.global_position = spawn.global_position
	coin.apply_impulse(Vector2(randf_range(-50,50),-150))
