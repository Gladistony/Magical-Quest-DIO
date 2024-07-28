extends Node2D

const WAIT_DURATION := 1.0

@onready var plataforma := $AnimatableBody2D as AnimatableBody2D
@export var move_speed := 3.0
@export var distance := 192 #vezes 16px que é o tamanho do tile
@export var move_horizontal := true

var follow := Vector2.ZERO
var plattaform_center := 16


# Called when the node enters the scene tree for the first time.
func _ready():
	move_plataform()

func _physics_process(_delta):
	plataforma.position = plataforma.position.lerp(follow, 0.5)

func move_plataform():
	var move_direction := Vector2.RIGHT * distance if move_horizontal else Vector2.UP * distance
	var duration := move_direction.length() / float(move_speed*plattaform_center)
	
	var plataform_tween := create_tween().set_loops().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	plataform_tween.tween_property(self, "follow", move_direction, duration).set_delay(WAIT_DURATION)
	plataform_tween.tween_property(self, "follow", Vector2.ZERO, duration).set_delay(WAIT_DURATION)
	
