extends StaticBody2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var coll_door = $CollisionShape2D
	if Global.room_entered:
		self.set_visible(true)
		coll_door = Vector2(-99992, -304)

	else:
		self.set_visible(false)
		coll_door = Vector2(9999, 9999)
