extends Node2D

func _process(delta):
	if Input.is_action_just_pressed("ui_espace"):
		var EfeitoMatinho = load("res://EfeitoMatinho.tscn")
		var efeitoMatinho = EfeitoMatinho.instance()
		efeitoMatinho.global_position = global_position
		var world = get_tree().current_scene
		world.add_child(efeitoMatinho)
		queue_free()

