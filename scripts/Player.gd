extends KinematicBody2D



var velocity = Vector2.ZERO
var roll_vector = Vector2.DOWN
export var ACELERATION = 50
export var MAX_SPEED = 80
export var ROLL_SPEED = 111
export var FRICTION = 450

enum{
	MOVE,
	ROLL,
	ATTACK
}
var state
var status = PlayerStatus
onready var animation = $AnimationPlayer	
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var swordHitobox = $HitboxPivot/SwordHitbox
onready var hurtbox = $Hurtbox

func _ready():
	status.connect("no_health",self,"queue_free")
	animationTree.active = true
	swordHitobox.knockback_vector = roll_vector
	state = MOVE
	
func _process(delta):
	match state:
		MOVE:
			move_state(delta)
		ROLL:
			roll_state(delta)
		ATTACK:
			attack_state(delta)

func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_d") - Input.get_action_strength("ui_a")
	input_vector.y = Input.get_action_strength("ui_s") - Input.get_action_strength("ui_w")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		roll_vector = input_vector
		swordHitobox.knockback_vector = input_vector
		animationTree.set("parameters/Parado/blend_position", input_vector)
		animationTree.set("parameters/Correndo/blend_position", input_vector)
		animationTree.set("parameters/Atacando/blend_position", input_vector)
		animationTree.set("parameters/Rolando/blend_position", input_vector)
		animationState.travel("Correndo")
			
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACELERATION * delta)
	else :
		animationState.travel("Parado")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	move()
	
	if Input.is_action_just_pressed("ui_espace"):
		state = ATTACK
	if Input.is_action_just_pressed("ui_z"):
		state = ROLL

func attack_state(delta):	
	animationState.travel("Atacando")
	
func roll_state(delta):	
	velocity = roll_vector * ROLL_SPEED
	animationState.travel("Rolando")
	move()
	
func move():
	velocity = move_and_slide(velocity)
	
func attack_animation_finished():
	state = MOVE

func roll_animation_finished():
	velocity = velocity * 0.8
	state = MOVE


func _on_Hurtbox_area_entered(area):
	status.health -= 1
	hurtbox.iniciar_invencibilidade(.5)
	hurtbox.criar_efeito_hit()
