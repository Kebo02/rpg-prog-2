extends CanvasLayer

var player = null
var enemy = null

@onready var enemy_hp = $enemy_hp
@onready var player_hp = $player_hp
@onready var player_mana = $player_mana
@onready var skills_menu = $skills_menu
@onready var main_menu = $main_menu
@onready var game_over_screen = $game_over_screen

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
	$main_menu/Attack_button.disabled = is_disabled
	$main_menu/Defend_button.disabled = is_disabled
	$main_menu/Flee_button.disabled = is_disabled
	
func player_wins() -> bool:
	if enemy.hp <= 0:
		enemy.queue_free()
		get_tree().paused = false
		queue_free()
		return	true
	return false	



#Helper Methods >
	
	
	
 

#Button Functions <
func _on_attack_button_pressed() -> void:
	main_menu.hide()
	skills_menu.show()

	
func _on_defend_button_pressed() -> void:
	player.mana = clamp(player.mana + (player.max_mana/4.0),0,player.max_mana)
	player_mana.value = player.mana
	player.is_defending = true 
	enemy_turn()
	
func _on_flee_button_pressed() -> void:
	enemy.stop_the_entity()
	get_tree().paused = false
	queue_free()
	
func _on_default_attack_pressed() -> void:
	skills_menu.hide()
	main_menu.show()
	if not is_instance_valid(enemy) or enemy.hp <= 0:
		return	
	enemy.hp -= player.dmg
	enemy_hp.value = enemy.hp
	print("you dealt ",player.dmg," hp to the enemy")
	print("enemy has " , enemy.hp, " hp left")
	if player_wins():
		return
	enemy_turn()	
		
	
func _on_back_button_pressed() -> void:
	skills_menu.hide()
	main_menu.show()
	
func _on_gamble_pressed() -> void:
	if player.mana < 5:
		return 
	skills_menu.hide()
	main_menu.show()	
	if randi_range(0,100) >= 40:
		enemy.hp -= player.dmg*2
		player.mana -= 5
		player_mana.value = player.mana
		enemy_hp.value = enemy.hp
	else:
		player.mana -= 5
		player_mana.value = player.mana
	
	if player_wins():
		return	
	enemy_turn()	

func _on_spell_pressed() -> void:
	if player.mana <10:
		return	
		
	skills_menu.hide()
	main_menu.show()		
	enemy.hp -= (player.magic_dmg*1.5)
	player.mana -= 10
	
	player_mana.value = player.mana
	enemy_hp.value = enemy.hp
	
	if player_wins():
		return
	enemy_turn()		
func _on_try_again_btn_pressed() -> void:
	get_tree().paused = false
	queue_free()
	get_tree().change_scene_to_file("res://scenes/rpg_prog_2.tscn")
	
func _on_exit_btn_pressed() -> void:
	get_tree().quit()
#Button Functions >

#Enemy Attack Phase <
func enemy_turn() -> void:
	set_buttons_disabled(true)
	await get_tree().create_timer(1.0).timeout
	player.hp -= enemy.dmg/2 if player.is_defending else enemy.dmg 
	player_hp.value = player.hp
	
	player.is_defending = false
	
	if player.hp <= 0 :
		var messages =  [ 
		"May you be reborn",
		"Your fate shall be altered",
		]	
		var random_index = randi()% messages.size()
		$game_over_screen/death_message.text = messages[random_index]		
		game_over_screen.show()
		get_tree().paused = true
		
	else:
		set_buttons_disabled(false)		
#Enemy Attact Phase >
