extends CharacterBody2D

@export var speed : int = 200 
var sprint_speed = speed * 2 
var is_sprinting : bool = false 
var animation_walk : float = 1.5 
var animation_sprint = 4 
var last_move : String = "" 
var is_atacking : bool = false 
var last_atack = Vector2()
var stop_player : bool = false
var player_position

#var initial_player_position = []

@export var player_health : float = 3.0
@export var enemy_health : float = 3.0
#@export var is_human : bool = true #per activar la IA

# ai movement
var _action = Vector2(616, 488)

# @onready var colision_shape := $"Coll_jugador"
@onready var ai_controller := $AIController2D
@onready var raycast_sensor: RaycastSensor2D = $"RaycastSensor2D"

@onready var key_1 := $"../key_1"
@onready var door_1 := $"../door_1"
@onready var enemy := $"../enemy"



var best_key_door_distance = 10000.0
var win_count = 0
var lose_count = 0
var key_count = 0

#func _on_area_key_1_body_entered(_body):
#	position = Vector2(1024.0, 576.0)
#	ai_controller.reward += 1.0

#func _on_area_door_1_body_entered(_body):
#	position = Vector2(1024.0, 576.0)
#	if "door_1" in Global.keys_founded:
#		ai_controller.reward += 1.0
#	else:
#		ai_controller.reward -= 1.0

func _on_animated_sprite_2d_animation_finished(): 
	if $AnimatedSprite2D.animation == "atk_" + last_move: 
		is_atacking = false
#		remove_child($area_jugador) 


func game_over():
	# recolocar la key
	Global.random()
	# inicialitza claus porta enemic... 
	Global.reset_game = true
	stop_player = false
	is_atacking = false
	$AnimatedSprite2D.stop()
	player_health = 3
	position = Vector2(616, 488)
	_action = position
	key_count = 0
	key_1 = $"../key_1"
	best_key_door_distance = position.distance_to(key_1.position)
	$AnimatedSprite2D.play("idle_down")
	ai_controller.reset()

#	key_just_entered = false
#	door_just_entered = false
#	just_hit_wall = false
#	just_hit_enemy = false
#	key_count = 0
#	_velocity = Vector2.ZERO

	
#func _on_area_enemy_body_entered(body):
func _on_area_2d_2_body_entered(_body):
	if _body.is_in_group("enemy") and not _body.disabled_enemy:
		$Aud_hit.play()
		player_health -= 1
		ai_controller.reward -= 5.0
		$AnimationPlayer_hit.play("hit")
		if player_health <= 0:
			ai_controller.done = true
			ai_controller.reward -= 5.0
			lose_count += 1
			$AnimationPlayer_hit.play("RESET")
			$AnimationPlayer.play("RESET")
			# Atura el moviment del jugador
			stop_player = true
			$AnimatedSprite2D.play("death")
			await $Aud_hit.finished
			$AnimatedSprite2D.play("death")
			#$Aud_gameover.play()
			#await $Aud_gameover.finished
			# inicialitza clau, jugador enemic...
			game_over()
			
			#get_tree().reload_current_scene()
		print("el jugador té " + str(player_health) + (" vides" if player_health > 1 else " vida"))
	
func _on_area_jugador_body_entered(_body):
	print(_body.name)
	if _body.is_in_group("enemy"):
		_body.enemy_health -= 1
		ai_controller.reward += 5.0
		print(_body.enemy_health)

	if _body.is_in_group("tile_map") and  ai_controller.heuristic != "human":
		ai_controller.done = true
		ai_controller.reward -= 1.0

	
		#var body_name = _body.name
		#if body_name not in Global.enemys:
			#Global.enemys[body_name] = enemy_health - 1
		#else:
			#Global.enemys[body_name] -= 1
		#print(Global.enemys[body_name])

func _ready():
	ai_controller.init(self)
	raycast_sensor.activate()
	$AnimatedSprite2D.play("idle_down")
	last_move = "down"
	#position = initial_player_position
	#stop_player_func()
#
#func stop_player_func():
	##inicialitza
	#ai_controller_2d.reset()


func _physics_process(delta):
	var movement := Vector2() #moviment 2d
	if stop_player == false:
		if ai_controller.heuristic == "human":
			if not is_atacking: 
				#es defineix en quina direcció es el moviment
				if Input.is_action_pressed("right") and Input.is_action_pressed("down"):
					movement.x += 1
					movement.y += 1
					$AnimatedSprite2D.play("down_right")
					last_move = "down_right"
				elif Input.is_action_pressed("left") and Input.is_action_pressed("down"):
					movement.x -= 1
					movement.y += 1
					$AnimatedSprite2D.play("down_left")
					last_move = "down_left"
				elif Input.is_action_pressed("right") and Input.is_action_pressed("up"):
					movement.x += 1
					movement.y -= 1
					$AnimatedSprite2D.play("up_right")
					last_move = "up_right"
				elif Input.is_action_pressed("left") and Input.is_action_pressed("up"):
					movement.x -= 1
					movement.y -= 1
					$AnimatedSprite2D.play("up_left")
					last_move = "up_left"
				elif Input.is_action_pressed("right"):
					movement.x += 1
					$AnimatedSprite2D.play("right")
					last_move = "right"
				elif Input.is_action_pressed("left"):
					movement.x -= 1
					$AnimatedSprite2D.play("left")
					last_move = "left"
				elif Input.is_action_pressed("down"):
					movement.y += 1
					$AnimatedSprite2D.play("down")
					last_move = "down"
				elif Input.is_action_pressed("up"):
					movement.y -= 1
					$AnimatedSprite2D.play("up")
					last_move = "up"
				else: 
					$AnimatedSprite2D.play("idle_" + last_move) #quan no es pren cap boto s'activa l'animació d'aturada
			#activació de la animació d'atac 
			if Input.is_action_just_pressed("atack"):
				is_atacking = true
				$AnimatedSprite2D.play("atk_" + last_move)
				last_atack = "atk_" + last_move
				
				if last_atack == "atk_right":
					$AnimationPlayer.play("atk_right")
				elif last_atack == "atk_left":
					$AnimationPlayer.play("atk_left")
				elif last_atack == "atk_up":
					$AnimationPlayer.play("atk_up")
				elif last_atack == "atk_down":
					$AnimationPlayer.play("atk_down")
				elif last_atack == "atk_up_right":
					$AnimationPlayer.play("atk_up_right")
				elif last_atack == "atk_up_left":
					$AnimationPlayer.play("atk_up_left")
				elif last_atack == "atk_down_right":
					$AnimationPlayer.play("atk_down_right")
				elif last_atack == "atk_down_left":
					$AnimationPlayer.play("atk_down_left")

	#		if is_atacking == true:
	#			atack_area.position = last_atack * 7

				#animacions de corre
			if $AnimatedSprite2D.animation == last_move:
				if Input.is_action_pressed("sprint"):
					is_sprinting = true
					$AnimatedSprite2D.set_speed_scale(animation_sprint)
				else:
					is_sprinting = false
					$AnimatedSprite2D.set_speed_scale(animation_walk)
					
		#if stop_player == true and not Global.reset_game:
			#$AnimatedSprite2D.play("death")
	# si is_human=f la IA controla el personatge
		else:
		#	movement.x = ai_controller.move.x
		#	movement.y = ai_controller.move.y
			movement = _action
			
	if Global.reset_game:
		player_health = 3
		position = Vector2(616, 488)
		_action = position
		key_count = 0
		key_1 = $"../key_1"
		best_key_door_distance = position.distance_to(key_1.position)

	if Global.ind_key_founded:
		ai_controller.reward += 10.0
		key_count = 1
		door_1 = $"../door_1"
		best_key_door_distance = position.distance_to(door_1.position)

	#normalitzar els vectors
	if movement.length() > 0:
		movement = movement.normalized() * speed
		if is_sprinting:
			movement *= 2 # velocitat * 2
	
	if player_health == 3:
		$CanvasLayer/animspr_health.play("3_cors")
	elif player_health == 2:
		$CanvasLayer/animspr_health.play("2_cors")
	elif player_health == 1:
		$CanvasLayer/animspr_health.play("1_cor")
	elif player_health <= 0:
		$CanvasLayer/animspr_health.play("0_cors")
	#
	#if Global.reset_game == true:
		#$AnimatedSprite2D.stop("death")
		#player_health = 3
		#position = Vector2(616, 488)
		##position = initial_player_position
		
	move_and_collide(movement * delta)
	#move_and_slide()
	if stop_player == false:
		update_reward()

func update_reward():
	ai_controller.reward -= 0.01  # step penalty
	ai_controller.reward += shaping_reward()


func shaping_reward():
	var s_reward = 0.0
	var key_distance = 10000.0
	if "door_1" not in Global.keys_founded and key_1 in get_tree().get_nodes_in_group("key"):
		position.distance_to(key_1.position)
	elif "door_1" not in Global.is_open_door:
		position.distance_to(door_1.position)

	if key_distance < best_key_door_distance:
		s_reward += best_key_door_distance - key_distance
		best_key_door_distance = key_distance

	s_reward /= 32.0  # tile map obstacles size 
	return s_reward

func get_key_door_position():
#	if key_count==0:
	if "door_1" not in Global.keys_founded and key_1 in get_tree().get_nodes_in_group("key"):
		return $"../key_1".global_position
	elif "door_1" not in Global.is_open_door:
		return $"../door_1".global_position
	else:
		return [0,0]

func get_enemy_position():
	if len(get_tree().get_nodes_in_group("enemy"))>0:   # si n'hi ha un
		return $"../enemy".global_position
	else :
		return [0,0] 

# falta wall hit

#func wall_hit():
#	ai_controller.done = true
#	ai_controller.reward -= 10.0
#	just_hit_wall = true
#	game_over()
