extends Control

@onready var life_count = $Container/life_container/life_count as Label
@onready var score_count = $Container/score_container/score_count as Label
@onready var timer_count = $Container/timer_container/timer_count as Label
@onready var coins_counter = $Container/coins_container/coins_counter as Label
@onready var clock_timer = $Container/clock_timer as Timer

var minutes = 0
var seconds = 0
@export_range(0,5) var defaut_minutes := 2
@export_range(0,59) var defaut_seconds := 0

# Called when the node enters the scene tree for the first time.
func _ready():
	coins_counter.text = str("%04d" % Global.coins)
	score_count.text = str("%04d" % Global.score)
	life_count.text = str("%02d" % Global.life)
	reset_clock_timer()
	timer_count.text = str("%02d" % defaut_minutes + ":" + "%02d" % defaut_seconds)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	coins_counter.text = str("%04d" % Global.coins)
	score_count.text = str("%04d" % Global.score)
	life_count.text = str("%02d" % Global.life)


func _on_clock_timer_timeout():
	if seconds == 0:
		if minutes > 0:
			minutes -= 1
			seconds = 60
	seconds -= 1	
	timer_count.text = str("%02d" % minutes + ":" + "%02d" % seconds)

func reset_clock_timer():
	minutes = defaut_minutes
	seconds = defaut_seconds
