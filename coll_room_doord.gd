extends CollisionShape2D


func _physics_process(delta):
	if Global.room_entered:
		#process_mode = Node.PROCESS_MODE_INHERIT
		print(process_mode)

	if not Global.room_entered:
		print(process_mode)

