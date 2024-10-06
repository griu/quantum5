extends StaticBody2D



func _on_area_door_body_entered(_body):
	if _body.is_in_group("jugador"):
		if self.name in Global.keys_founded:
			_body.ai_controller.reward += 20.0
			_body.win_count += 1
			# reseteja claus porta	
			Global.reset_game = true
		# 	random de la clau
			Global.random()
			$AnimationPlayer.play("door_unblocked")
			await $AnimationPlayer.animation_finished
			Global.is_open_door += [self.name]
			
		else:
			$AnimationPlayer.play("door_blocked")
		
	
	



