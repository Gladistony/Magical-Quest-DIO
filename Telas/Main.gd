extends Control
@onready var check_button = $Container/VBoxContainer/CheckButton as CheckButton
@onready var rank_usuario = $Container/VBoxContainer/HBoxContainer/RankUsuario
@onready var prim = $Container/VBoxContainer/HBoxContainer/RankUsuario/prim
@onready var secon = $Container/VBoxContainer/HBoxContainer/RankUsuario/secon
@onready var terc = $Container/VBoxContainer/HBoxContainer/RankUsuario/terc


func _on_sair_pressed():
	get_tree().quit()


func _on_inicio_pressed():
	get_tree().change_scene_to_file("res://Fases/World-1.tscn")


func _on_check_button_pressed():
	Global.mostrarcontroles = check_button.button_pressed

func _ready():
	#Firebase.Auth.login_succeeded.connect(_on_login)
	#Firebase.Auth.login_failed.connect(_off_login)
	#Firebase.Auth.login_anonymous()
	var colecao : FirestoreCollection = Firebase.Firestore.collection("rankusuarios")
	var doc = await colecao.get_doc("A94zU0fSYwO8t82OShnX")
	var jdoc = doc.document
	var valores = jdoc["membros"]
	var minhaMatriz = []
	for nome in valores.mapValue.fields:
		minhaMatriz.append([nome, valores.mapValue.fields[nome].integerValue])
	minhaMatriz.sort_custom(extrairValor)
	var primeiro = "Não encontrado"
	var segundo = "Não encontrado"
	var terceiro = "Não encontrado"
	if len(minhaMatriz) > 0:
		primeiro = minhaMatriz[0][0] + " - " + minhaMatriz[0][1] + " pts"
	if len(minhaMatriz) > 1:
		segundo = minhaMatriz[1][0] + " - " + minhaMatriz[1][1] + " pts"
	if len(minhaMatriz) > 2:
		terceiro = minhaMatriz[2][0] + " - " + minhaMatriz[2][1] + " pts"
	rank_usuario.visible = true
	prim.text = "1° " + primeiro
	secon.text = "2° " +  segundo
	terc.text = "3° "+ terceiro

func extrairValor(valora, valorb):
	return int(valora[1]) > int(valorb[1])
