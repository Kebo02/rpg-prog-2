extends CharacterBody2D
var player = null
var speed:int = 60

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if player != null:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		animated_sprite.play("slime")
		if direction.x != 0:
			animated_sprite.flip_h = direction.x < 0

	else:
		velocity = Vector2.ZERO
		animated_sprite.stop()
	move_and_slide()
	
func _on_detection_shape_body_entered(body: Node2D) -> void:
	if body.name == "player":
		player = body


func _on_detection_shape_body_exited(body: Node2D) -> void:
	if body.name == "player":
		player = null
