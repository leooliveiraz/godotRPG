extends KinematicBody2D

var knockback = Vector2.ZERO
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200 *delta)
	knockback = move_and_slide(knockback)


func _on_Hurtbox_area_entered(area):
	if area.get('knockback_vector'):
		print(area.knockback_vector)
		knockback = area.knockback_vector * 180
