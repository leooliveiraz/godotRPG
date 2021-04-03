extends KinematicBody2D



var velocity = Vector2.ZERO
var ACELERATION = 100
var MAX_SPEED = 100
var FRICTION = 150
onready var animation = $AnimationPlayer	
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")


func _ready():
	pass
	
func _process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_d") - Input.get_action_strength("ui_a")
	input_vector.y = Input.get_action_strength("ui_s") - Input.get_action_strength("ui_w")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Parado/blend_position", input_vector)
		animationTree.set("parameters/Correndo/blend_position", input_vector)
		if !animationState.is_playing():
			animationState.travel("Correndo")
			
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACELERATION * delta)
	else :
		animationState.travel("Parado")
		animationState.stop()
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	velocity = move_and_slide(velocity)
