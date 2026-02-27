extends CharacterBody2D
const SPEED = 120.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	velocity = direction * SPEED
	
	#walking animations
	if direction.x > 0:
		animated_sprite.play("walk_right")
		animated_sprite.flip_h = false
	elif direction.x < 0:
		animated_sprite.play("walk_right")	
		animated_sprite.flip_h = true
	elif direction.y > 0:
		animated_sprite.play("walk_down")
	elif direction.y < 0:
		animated_sprite.play("walk_up")
	else: 
		animated_sprite.stop()	
		
		
 
	
	move_and_slide()
