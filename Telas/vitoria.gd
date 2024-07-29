extends Control

@onready var pontos = $VBoxContainer/pontos
@onready var nome = $VBoxContainer/nome
@onready var v_box_container = $VBoxContainer


var pt = 500
# Called when the node enters the scene tree for the first time.
func _ready():
	pt = Global.score
	pt += Global.coins * 200
	var segundos = Global.segundos + Global.minutos * 60
	pt += segundos * 10
	pontos.text = "Total de pontos: " + str("%04d" % pt)

func _on_enviar_2_pressed():
	get_tree().change_scene_to_file("res://Telas/Main.tscn")


func _on_enviar_pressed():
	if len(nome.text) > 5 and valido(nome.text):
		enviar()
	else:
		_on_enviar_2_pressed()

func valido(txt: String) -> bool:
	var palavras_proibidas = ["palavra1", "palavra2", "xingamento"]
	for palavra in palavras_proibidas:
		if txt.find(palavra) != -1:
			return false
	if txt.find(" ") != -1:
		return false
	var caracteres_especiais = "!@#$%^&*()_+=<>?.,;:'\""
	for char in caracteres_especiais:
		if txt.find(char) != -1 and char != "-":
			return false
	return true


func enviar():
	v_box_container.visible = false
	var colecao : FirestoreCollection = Firebase.Firestore.collection("rankusuarios")
	var doc = await colecao.get_doc("A94zU0fSYwO8t82OShnX")
	var jdoc = doc.document
	var valores = jdoc["membros"]
	var minhaMatriz = {}
	for nome in valores.mapValue.fields:
		minhaMatriz[nome] = int(valores.mapValue.fields[nome].integerValue)
	adicionar_elemento(minhaMatriz)
	doc.add_or_update_field("membros", minhaMatriz)
	doc = await  colecao.update(doc)
	_on_enviar_2_pressed()
	
func adicionar_elemento(matriz):
	if !matriz.has(nome.text):
		matriz[nome.text] = pt
