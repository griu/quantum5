extends Node2D

var key_to_spawn = preload("res://key_1.tscn")
var enemy_to_spawn = preload("res://enemy.tscn")

func _ready():
	spawn()

func spawn():
	var spawn_key = key_to_spawn.instantiate()
	spawn_key.position = Vector2(432, 300) 
	#spawn_key.door_name = "door_1"
	add_child(spawn_key)
	 
	var spawn_enemy = enemy_to_spawn.instantiate()
	spawn_enemy.position = Vector2(70, -0.45) 

	add_child(spawn_enemy)

