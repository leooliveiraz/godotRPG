extends AnimatedSprite

func _ready():
	self.connect("animation_finished", self , "_on_AnimatedSprite_animation_finished")
	frame = 0
	play("Animando")


func _on_AnimatedSprite_animation_finished():
	queue_free()