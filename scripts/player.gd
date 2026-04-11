extends CharacterBody2D
const SPEED = 120.0
#collectibles
var sunflower: int = 0

#attributes
var hp: int = 10
var max_hp: int = 10
var mana: int = 10
var max_mana: int = 30
var dmg: int = 4
#states
var is_defending: bool = false


@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func update_hud():
	$"../HUD/Label".text = "x " + str(sunflower)

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
