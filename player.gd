extends CharacterBody2D

@export var velocidad := 200.0
@export var velocidad_salto := -1000.0
@export var gravedad := 900.0
@export var maximotiempodesalto := 1
@export var jump_hold_force := -250.0

var tiempodesalto := 0.0
var saltando := false

@onready var anim = $AnimatedSprite2D

func _physics_process(delta):
	var direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = direction * velocidad
	if not is_on_floor():
		velocity.y += gravedad * delta #gravedad
	# Primer salto
	if is_on_floor():
		saltando = false
		tiempodesalto = 0.0
	elif Input.is_action_just_pressed("salto"):
			velocity.y = velocidad_salto
			saltando = true
			velocity.y += gravedad * delta
	# Doble salto
	#elif saltando and Input.is_action_pressed("salto") and tiempodesalto < maximotiempodesalto:
		#velocity.y += jump_hold_force * delta
		#tiempodesalto += delta
	elif Input.is_action_just_released("salto"):
		saltando = false

	# Animaciones
	if not is_on_floor():
		anim.play("jump")
	elif direction != 0:
		anim.play("run")
	if is_on_floor():
		anim.play("idle")
	# Vuelta de sprite
	if direction != 0:
		anim.flip_h = direction > 0                                                                                                      

	move_and_slide()
