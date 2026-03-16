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
