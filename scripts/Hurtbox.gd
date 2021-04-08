extends Area2D

export(bool) var mostrar_hit = true
const efeitoHit = preload("res://EfeitoHit.tscn")

func _on_Hurtbox_area_entered(area):
	if(mostrar_hit):
		var efeito  = efeitoHit.instance()
		var main = get_tree().current_scene
		main.add_child(efeito)
		efeito.global_position = self.global_position
