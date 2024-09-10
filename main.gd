extends Node2D

var object_to_spawn = preload("res://key_1.tscn")


func _ready():
	spawn()



func spawn():
	var spawn_key = object_to_spawn.instantiate()
	spawn_key.position = Vector2(1272, 576) 
	#spawn_key.door_name = "door_1"
	add_child(spawn_key)
	 

