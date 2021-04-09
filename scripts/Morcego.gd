extends KinematicBody2D

const EfeitoMorteInimigo = preload("res://EfeitoMorteInimigo.tscn")

onready var status = $Status
onready var playerDetection = $PlayerDetectionZone
onready var sprite = $AnimatedSprite
onready var wanderControll = $WanderControll

var knockback = Vector2.ZERO
var forca = 80

var velocidade = Vector2.ZERO
export var ACELERACAO = 30
export var VELOCIDADE_MAX = 80
export var FRICCAO = 200
export var WANDER_TARGET_RANGE = 4

enum {
	IDLE,
	WANDER,
	CHASE
}

var estado = pick_new_state([IDLE,WANDER])

func _ready():
	print(status.max_health, status.health)

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200 *delta)
	knockback = move_and_slide(knockback)
	
	match estado:
		IDLE:
			idle(delta)
		WANDER:
			wander(delta)
		CHASE:
			chase_player(delta)
	velocidade = move_and_slide(velocidade)
	
func idle(delta): 
	velocidade == velocidade.move_toward(Vector2.ZERO, FRICCAO * delta)
	player_avistado()
	if wanderControll.get_time_left() <= 0:
		estado = pick_new_state([IDLE,WANDER])
		wanderControll.start_wander_timer(rand_range(1,3))

func wander(delta):
	player_avistado()
	if wanderControll.get_time_left() == 0:
		estado = pick_new_state([IDLE,WANDER])
		wanderControll.start_wander_timer(rand_range(1,3))
	
	var direcao = global_position.direction_to(wanderControll.target_position)
	velocidade = velocidade.move_toward(direcao * VELOCIDADE_MAX, ACELERACAO * delta)
	
	if global_position.distance_to(wanderControll.target_position) <= WANDER_TARGET_RANGE:
		estado = pick_new_state([IDLE,WANDER])
		wanderControll.start_wander_timer(rand_range(1,3))

func chase_player(delta):
	var player = playerDetection.player
	if player != null:
		var direcao = global_position.direction_to(player.global_position)
		velocidade = velocidade.move_toward(direcao * VELOCIDADE_MAX, ACELERACAO * delta)
	else:
		estado = IDLE
	sprite.flip_h = velocidade.x < 0
		
func player_avistado():
	if playerDetection.pode_ver_jogador():
		estado = CHASE
	
func pick_new_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()
	
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
