extends Node2D

var door_name : String = "door_1"


func _ready():
	self.position += Global.size_block * Vector2(Global.key_x, Global.key_y)
	print(self.position)
	

func _on_area_key_body_entered(_body):
	if _body.is_in_group("jugador"):
		Global.keys_founded.append(door_name)
		queue_free()
	
