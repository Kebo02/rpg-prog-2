extends CharacterBody2D
var player = null
var speed:int = 60

var hp: int = 5
var max_hp: int = 10
var dmg = 2

const BATTLE_SCENE = preload("res://scenes/battle_scene.tscn")


@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if player != null:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		animated_sprite.play("blue_slime_walking_animation")
		if direction.x != 0:
			animated_sprite.flip_h = direction.x < 0

	else:
		velocity = Vector2.ZERO
		animated_sprite.stop()
	move_and_slide()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		# Jeśli to gracz, odpalamy walkę!
		if collision.get_collider().name == "player":
			start_battle(collision.get_collider())
	
	
func _on_detection_shape_body_entered(body: Node2D) -> void:
	if body.name == "player":
		player = body


func _on_detection_shape_body_exited(body: Node2D) -> void:
	if body.name == "player":
		player = null
		
func start_battle(player_node):
	var arena = BATTLE_SCENE.instantiate()
	arena.player = player_node
	arena.enemy = self
	get_tree().root.add_child(arena)
	get_tree().paused = true
