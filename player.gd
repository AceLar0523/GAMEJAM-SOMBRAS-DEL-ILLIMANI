extends CharacterBody2D

# Velocidad de movimiento del personaje
@export var speed := 120

# Referencias a los nodos de animación y sprite
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D

func _physics_process(delta: float) -> void:
	# Obtener la entrada del jugador para el movimiento horizontal y vertical
	var horizontal_direction: float = Input.get_axis("ui_left", "ui_right")
	var vertical_direction: float = Input.get_axis("ui_up", "ui_down")
	
	# Crear un vector de dirección basado en la entrada
	var direction: Vector2 = Vector2(horizontal_direction, vertical_direction)
	
	# Normalizar el vector de dirección para evitar un movimiento más rápido en diagonal
	if direction.length() > 1.0:
		direction = direction.normalized()
		
	# Establecer la velocidad del personaje
	velocity = direction * speed
	
	# Actualizar las animaciones y la orientación del sprite
	update_animation(direction)
	update_sprite_flip(horizontal_direction)
	
	# Mover el personaje
	move_and_slide()

# Función para gestionar las animaciones
func update_animation(direction: Vector2) -> void:
	if direction.y < 0:
		anim.play("walk_arriba")
	elif direction.y > 0:
		anim.play("walk_abajo")
	elif direction.x != 0:
		anim.play("walk")
	else:
		anim.play("idle")

# Función para voltear el sprite horizontalmente
func update_sprite_flip(horizontal_direction: float) -> void:
	if horizontal_direction != 0:
		sprite.flip_h = horizontal_direction < 0
