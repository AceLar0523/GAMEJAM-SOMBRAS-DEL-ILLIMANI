extends CharacterBody2D

var speed := 120
var jump := 250  # Se mantiene por si lo necesitas en el futuro
const gravity := 9

@onready var anim := $AnimationPlayer
@onready var sprite := $Sprite2D

# --- Mejoras para el NPC ---

# 1. Definimos los estados del NPC para saber qué está haciendo en cada momento.
enum State { CAMINANDO_DERECHA, CAMINANDO_IZQUIERDA, QUIETO }

# 2. Variables para controlar el estado actual y el tiempo.
var estado_actual = State.CAMINANDO_DERECHA
var temporizador = 0.0

# 3. Tiempos que durará cada estado (en segundos).
var tiempo_caminar = 2.0
var tiempo_quieto = 2.0


func _physics_process(delta):
	# Aplicamos la gravedad (mantenemos tu estructura original)
	if not is_on_floor():
		velocity.y += gravity

	# Actualizamos el temporizador en cada frame.
	temporizador += delta

	# --- Lógica de estados del NPC ---
	# Usamos 'match' para ejecutar un código diferente según el estado actual.
	match estado_actual:
		State.CAMINANDO_DERECHA:
			# Moverse a la derecha
			velocity.x = speed
			anim.play("walk")
			sprite.flip_h = false  # El sprite mira a la derecha

			# Si han pasado 5 segundos, cambiamos de estado.
			if temporizador >= tiempo_caminar:
				estado_actual = State.CAMINANDO_IZQUIERDA
				temporizador = 0.0  # Reiniciamos el temporizador

		State.CAMINANDO_IZQUIERDA:
			# Moverse a la izquierda
			velocity.x = -speed
			anim.play("walk")
			sprite.flip_h = true  # El sprite mira a la izquierda

			# Si han pasado 5 segundos, cambiamos de estado.
			if temporizador >= tiempo_caminar:
				estado_actual = State.QUIETO
				temporizador = 0.0  # Reiniciamos el temporizador

		State.QUIETO:
			# Dejar de moverse
			velocity.x = 0
			anim.play("idle")

			# Si han pasado 2 segundos, volvemos a caminar a la derecha.
			if temporizador >= tiempo_quieto:
				estado_actual = State.CAMINANDO_DERECHA
				temporizador = 0.0  # Reiniciamos el temporizador

	# Finalmente, movemos el personaje.
	move_and_slide()
