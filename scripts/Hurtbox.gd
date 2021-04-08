extends Area2D

const efeitoHit = preload("res://EfeitoHit.tscn")
var invencibilidade = false setget set_invencible
onready var timer = $Timer
signal invencibilidade_inicio
signal invencibilidade_fim

func iniciar_invencibilidade(duracao):
	self.invencibilidade = true
	timer.start(duracao)
	
func set_invencible(value):
	invencibilidade = value	
	if invencibilidade:
		emit_signal("invencibilidade_inicio")
	else:
		emit_signal("invencibilidade_fim")
		
func criar_efeito_hit():
	var efeito  = efeitoHit.instance()
	var main = get_tree().current_scene
	main.add_child(efeito)
	efeito.global_position = self.global_position


func _on_Timer_timeout():
	self.invencibilidade = false


func _on_Hurtbox_invencibilidade_inicio():
	self.set_deferred("monitorable",false)

func _on_Hurtbox_invencibilidade_fim():
	self.set_deferred("monitorable",true)
