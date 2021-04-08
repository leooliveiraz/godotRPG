extends KinematicBody2D


onready var status = $Status
var knockback = Vector2.ZERO
var forca = 80
func _ready():
	print(status.max_health, status.health)
	pass # Replace with function body.

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200 *delta)
	knockback = move_and_slide(knockback)


func _on_Hurtbox_area_entered(area):
	status.health -= area.damage
	if area.get('knockback_vector'):
		knockback = area.knockback_vector * forca


func _on_Status_no_health():
	queue_free()
