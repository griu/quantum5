extends Area2D

var projectile_speed: int = 400
var lifespan: float = 5.0
var direction: Vector2 = Vector2.ZERO

func _ready():
	direction = Vector2(1, 0).rotated(rotation)
	set_process(true) # Activar el proceso para mover el proyectil
	$Timer.start(lifespan)

func _process(delta):
	# Mover el proyectil en la dirección dada por la variable "direction"
	position += direction * projectile_speed * delta

func _on_Timer_timeout():
	queue_free()
