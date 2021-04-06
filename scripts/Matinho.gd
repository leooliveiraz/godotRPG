extends Node2D

func create_grass_effect():
		var EfeitoMatinho = load("res://EfeitoMatinho.tscn")
		var efeitoMatinho = EfeitoMatinho.instance()
		efeitoMatinho.global_position = global_position
		var world = get_tree().current_scene
		world.add_child(efeitoMatinho)



func _on_Hurtbox_area_entered(area):
	create_grass_effect()
	queue_free()
