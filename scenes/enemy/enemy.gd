extends CharacterBody2D

@export var enemy_health : float = 3
@export var speed = 60
var disabled_enemy : bool = false


@export var player: Node2D
@onready var nav_agent = $NavigationAgent2D as NavigationAgent2D


#func _process(_delta):
	#if self.name in Global.enemys and Global.enemys[self.name] <= 0:
	
	

		
		#queue_free()
		#$death.play("temp")

		#Global.disabled_enemy = false
		
		#await $AnimationPlayer.stop
		#for node in get_tree().get_nodes_in_group("jugador"):
		#	player = node
		#self.disable_mode
		#queue_free()

func _ready() -> void:
	makepath()
	$AnimatedSprite2D.play("default")

func _physics_process(_delta: float) -> void:
	if enemy_health > 0 and not Global.reset_game:
		var dir = to_local(nav_agent.get_next_path_position()).normalized()
		velocity = dir * speed
		move_and_slide()
	
	if enemy_health <= 0 and not Global.reset_game:
		$AnimationPlayer.play("death")
	
	if Global.reset_game == true:
		enemy_health = 3
		$AnimationPlayer.stop()
		position = Vector2(539, 224)
		#position = initial_enemy_position

func makepath() -> void:
	for node in get_tree().get_nodes_in_group("jugador"):
		player = node
	nav_agent.target_position = player.global_position

func _on_timer_timeout():
	makepath()