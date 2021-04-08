extends Node2D

const EfeitoMatinho = preload("res://EfeitoMatinho.tscn")

func create_grass_effect():
		var efeitoMatinho = EfeitoMatinho.instance()
		efeitoMatinho.global_position = global_position
		get_parent().add_child(efeitoMatinho)
		



func _on_Hurtbox_area_entered(area):
	create_grass_effect()
	queue_free()
