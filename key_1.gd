extends Node2D

var door_name : String = "door_1"


func _ready():
	print(self.name)
	



#func _on_area_key_body_entered(_body):
	


func _on_area_key_body_entered(_body):
	Global.keys_founded.append(door_name)
	queue_free()
	
