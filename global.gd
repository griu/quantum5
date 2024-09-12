extends Node2D

var keys_founded = []
var is_open_door = []
var enemys = {}
var reset_game : bool = false

var width_tilemap : int = 18
var height_tilemap : int = 9
const size_block : int = 32

var key_x : int = randi_range(0, width_tilemap - 1)
var key_y : int = randi_range(0, height_tilemap - 1)

#var room_entered : bool = false
func _ready():
	pass

func _process(delta):
	if reset_game == true:
		keys_founded.clear()
		is_open_door.clear()
		enemys = {}
		key_x = randi_range(0, width_tilemap - 1)
		key_y = randi_range(0, height_tilemap - 1)
		reset_game = false
		get_tree().reload_current_scene()
