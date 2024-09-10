extends Node2D

var object_to_spawn = preload("res://door3.0.tscn")


func _ready():
	spawn()



func spawn():
	if Global.entered_room == true:
		var spawn_door = object_to_spawn.instantiate()
		spawn_door.position = Vector2(8, -192) 
		#spawn_door.door_name = "door_1"
		add_child(spawn_door)


