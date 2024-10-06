extends Node2D

var door_name : String = "door_1"


func _ready():
	#position += Global.size_block * Vector2(Global.key_x, Global.key_y)
	$AnimatedSprite2D.play("default")



func _on_area_key_body_entered(_body):
	if _body.is_in_group("jugador"):
		Global.keys_founded.append(door_name)
		Global.ind_key_founded = true
		queue_free()


func _physics_process(_delta):
	if Global.reset_game:
		queue_free()

#func _on_area_2d_2_area_entered(area):
	






