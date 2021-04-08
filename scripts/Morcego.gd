extends KinematicBody2D

const EfeitoMorteInimigo = preload("res://EfeitoMorteInimigo.tscn")

onready var status = $Status
onready var playerDetection = $PlayerDetectionZone
onready var sprite = $AnimatedSprite

var knockback = Vector2.ZERO
var forca = 80

var velocidade = Vector2.ZERO
export var ACELERACAO = 30
export var VELOCIDADE_MAX = 80
export var FRICCAO = 200

enum {
	IDLE,
	WANDER,
	CHASE
}

var estado = IDLE

func _ready():
	print(status.max_health, status.health)

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200 *delta)
	knockback = move_and_slide(knockback)
	
	match estado:
		IDLE:
			velocidade == velocidade.move_toward(Vector2.ZERO, FRICCAO * delta)
			player_avistado()
		WANDER:
			pass
		CHASE:
			chase_player(delta)
	velocidade = move_and_slide(velocidade)
	

func chase_player(delta):
	var player = playerDetection.player
	if player != null:
		var direcao = (player.global_position - global_position).normalized()
		velocidade = velocidade.move_toward(direcao * VELOCIDADE_MAX, ACELERACAO * delta)
		sprite.flip_h = velocidade.x < 0
	else:
		velocidade = Vector2.ZERO
		estado = IDLE
		
func player_avistado():
	if playerDetection.pode_ver_jogador():
		estado = CHASE
	
func _on_Hurtbox_area_entered(area):
	if area.get('damage'):
		status.health -= area.damage
	if area.get('knockback_vector'):
		knockback = area.knockback_vector * forca


func _on_Status_no_health():
	var efeitoMorte = EfeitoMorteInimigo.instance()
	efeitoMorte.global_position = global_position
	get_parent().add_child(efeitoMorte)
	queue_free()
