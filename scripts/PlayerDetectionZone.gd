extends Area2D

var player = null

func pode_ver_jogador():
	return player != null

func _on_PlayerDetectionZone_body_entered(body):
	player = body

func _on_PlayerDetectionZone_body_exited(body):
	player = null
