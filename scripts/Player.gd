extends KinematicBody2D



var velocity = Vector2.ZERO
var ACELERATION = 200
var MAX_SPEED = 100
var FRICTION = 20
	

func _ready():
	pass # Replace with function body.


func _process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_d") - Input.get_action_strength("ui_a")
	input_vector.y = Input.get_action_strength("ui_s") - Input.get_action_strength("ui_w")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACELERATION * delta)
	else :
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	velocity = move_and_slide(velocity)
