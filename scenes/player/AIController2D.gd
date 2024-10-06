extends AIController2D

func _ready():
	reset()


func _physics_process(_delta):
	n_steps += 1
	if n_steps > reset_after:
		needs_reset = true
		done = true

	if needs_reset:
		needs_reset = false
		reset()

func get_reward():
	return reward
	


func get_obs():
	var relative = to_local(_player.get_key_door_position())
	var enemy_relative = to_local(_player.get_enemy_position())
	var distance = relative.length() / 450.0
	var enemy_distance = enemy_relative.length() / 450.0
	relative = relative.normalized()
	enemy_relative = enemy_relative.normalized()
	var result := []
	result.append(((position.x / 576) - 0.5) * 2)
	result.append(((position.y / 288) - 0.5) * 2)
	result.append(relative.x)
	result.append(relative.y)
	result.append(distance)
	result.append(enemy_relative.x)
	result.append(enemy_relative.y)
	result.append(enemy_distance)
	result.append(_player.key_count)
	var raycast_obs = _player.raycast_sensor.get_observation()
	result.append_array(raycast_obs)
	
#	print(result)
	
	return {
		"obs": result,
	}

func set_action(action):
	_player._action.x = action["move"][0]
	_player._action.y = action["move"][1]

#var move = Vector2.ZERO
#@onready var jugador: CharacterBody2D = $".."
#@onready var key_1: Node2D = $"../../key_1"
#@onready var door_1: StaticBody2D = $"../../door_1"
#@onready var enemy: CharacterBody2D = $"../../enemy"
#@onready var TileMap_random: TileMap = $"../../TileMap_random"
#@onready var raycast_sensor = $"RayCastSensor2D"

#func get_obs() -> Dictionary:#
#	var obs := [
#		jugador.position.x,
#		jugador.position.y,]
#		
#	if "door_1" not in Global.keys_founded and key_1 in get_tree().get_nodes_in_group("key"):
#		obs += [ 
#			key_1.position.	x,
#			key_1.position.y, 
#		]
#	else:
#		obs += [ 0, 0,]
#	if "door_1" not in Global.is_open_door:
#		obs += [ 
#			door_1.position.x,
#			door_1.position.y,	
#	]
#	else:
#		obs += [ 0, 0,]	
#	if len(get_tree().get_nodes_in_group("enemy"))>0:   # si n'hi ha un
#		obs += [ 
#			enemy.position.x,
#			enemy.position.y,	
#	]
#	else:
#		obs += [ 0, 0,]	
#	#obs += [ 
#	obs.append_array(jugador.raycast_sensor.get_observation())
#
#	print(obs)
#	print(self.reward)
#	return {"obs" :obs}

	
func get_action_space() -> Dictionary:
	return {
		"move" : {
			"size": 2,
			"action_type": "continuous"
		},
		}
	
#func set_action(action) -> void:	
#	move.x = action["move"][0]
#	move.y = action["move"][1]
