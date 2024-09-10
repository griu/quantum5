extends StaticBody2D



func _on_area_door_body_entered(_body):
	if self.name in Global.keys_founded:
		$AnimationPlayer.play("door_unblocked")
		await $AnimationPlayer.animation_finished
		Global.is_open_door += [self.name]
		queue_free()
		
	else:
		$AnimationPlayer.play("door_blocked")
	
	
	
