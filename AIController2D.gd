extends AIController2D

var move = Vector2.ZERO

@onready var jugador: CharacterBody2D = $".."
@onready var key_1: Node2D = $"../../key_1"
@onready var door_1: StaticBody2D = $"../../door_1"
@onready var enemy: CharacterBody2D = $"../../enemy"



func get_obs() -> Dictionary:
	var obs := [
		jugador.position.x,
		jugador.position.y,]
		
	if "door_1" not in Global.keys_founded:
#	if key_1 in get_tree().get_nodes_in_group("key")
		obs += [ 
			key_1.position.	x,
			key_1.position.y, 
		]
	else:
		obs += [ 0, 0,]
	if "door_1" not in Global.is_open_door:
		obs += [ 
			door_1.position.x,
			door_1.position.y,	
	]
	else:
		obs += [ 0, 0,]	
	if len(get_tree().get_nodes_in_group("enemy"))>0:   # si n'hi ha un
		obs += [ 
			enemy.position.x,
			enemy.position.y,	
	]
	else:
		obs += [ 0, 0,]	
	print(obs)
	print(self.reward)
	return {"obs" :obs}

func get_reward() -> float:	
	return reward
	
func get_action_space() -> Dictionary:
	return {
		"move" : {
			"size": 2,
			"action_type": "continuous"
		},
		}
	
func set_action(action) -> void:	
	move.x = action["move"][0]
	move.y = action["move"][1]
