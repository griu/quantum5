extends Area2D



func _ready():
	print(self.name)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_jugador_area_exited(_body):
	Global.room_entered = true
	
