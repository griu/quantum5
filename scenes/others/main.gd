extends Node2D

var key_to_spawn = preload("res://scenes/key/key_1.tscn")


func _ready():
	spawn()
	

func spawn():
		var spawn_key = key_to_spawn.instantiate()
		spawn_key.position += Global.size_block * Vector2(Global.key_x, Global.key_y)
		#spawn_key.door_name = "door_1"
		add_child(spawn_key) 
		Global.random_spwan_key = false
	
func _physics_process(_delta):
	if Global.random_spwan_key:
		spawn()


