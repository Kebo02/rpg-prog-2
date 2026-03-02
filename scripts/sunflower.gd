extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":	
		body.sunflower += 1
		body.update_hud()
		
		#pickup sounds
		$AnimatedSprite2D.hide()
		$CollisionShape2D.set_deferred("disabled",true)
		$AudioStreamPlayer.play()
		await $AudioStreamPlayer.finished
		queue_free()
