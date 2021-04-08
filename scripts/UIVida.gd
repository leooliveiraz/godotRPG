extends Node

onready var texto = $RichTextLabel
var vida = 999 setget set_vida

func _ready():
	atualizar_vida(PlayerStatus.health)
	PlayerStatus.connect("health_changed",self,"set_vida")

func set_vida(value):
	vida = value
	atualizar_vida(PlayerStatus.health)
	
func atualizar_vida(vida):
	texto.text = str("Vida: ",vida)

