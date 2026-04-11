extends CanvasLayer

var player = null
var enemy = null

@onready var enemy_hp = $enemy_hp
@onready var player_hp = $player_hp
@onready var player_mana = $player_mana

func _ready() -> void:
	player_hp.max_value = player.max_hp
	player_mana.max_value = player.max_mana
	player_mana.value = player.mana
	player_hp.value = player.hp
	enemy_hp.max_value = enemy.max_hp
	enemy_hp.value = enemy.hp
	
func _process(delta: float) -> void:
	pass

#Helper Methods <
func set_buttons_disabled(is_disabled: bool) -> void:
	$HBoxContainer/Attack_button.disabled = is_disabled
	$HBoxContainer/Defend_button.disabled = is_disabled
	$HBoxContainer/Flee_button.disabled = is_disabled
#Helper Methods >
	
	
	


#Button Functions <
func _on_attack_button_pressed() -> void:
	if not is_instance_valid(enemy) or enemy.hp <= 0:
		return	
	enemy.hp -= player.dmg
	enemy_hp.value = enemy.hp
	print("you dealt ",player.dmg," hp to the enemy")
	print("enemy has " , enemy.hp, " hp left")
	if enemy.hp <= 0:
		enemy.queue_free()
		get_tree().paused = false
		queue_free()
	enemy_turn()	


func _on_defend_button_pressed() -> void:
	player.mana = clamp(player.mana + (player.max_mana/4.0),0,player.max_mana)
	player_mana.value = player.mana
	player.is_defending = true 
	enemy_turn()
func _on_flee_button_pressed() -> void:
	enemy.stop_the_entity()
	get_tree().paused = false
	queue_free()
	
#Button Functions >

#Enemy Attack Phase <
func enemy_turn() -> void:
	set_buttons_disabled(true)
	await get_tree().create_timer(1.0).timeout
	player.hp -= enemy.dmg/2 if player.is_defending else enemy.dmg 
	player_hp.value = player.hp
	
	player.is_defending = false
	
	if player.hp <= 0 :
		print("Game Over")
	else:
		set_buttons_disabled(false)		
#Enemy Attact Phase >
