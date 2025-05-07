extends CharacterBody2D

const velocidad = 300.0
const velocidad_salto = -500.0
const gravedad = 980.0
const factor_caida = 0.9 
@onready var animationPlayer = $AnimationPlayer
@onready var sprite2D = $Sprite2D
var jump_count = 0
var was_on_floor = false 

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravedad * delta
	else:
		jump_count = 0

	
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = velocidad_salto
		jump_count += 1  
		if jump_count == 1:
			animationPlayer.play("salto")  
		else:
			animationPlayer.play("Caida")  

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * velocidad
	else:
		velocity.x = move_toward(velocity.x, 0, velocidad)
	if animationPlayer.current_animation == "Caida" and not is_on_floor():
		velocity *= factor_caida  # <<< CAMBIO

	move_and_slide()

	animations(direction)
	if direction == -1:
		sprite2D.flip_h = false
	elif direction == 1:
		sprite2D.flip_h = true

func animations(direction):
	if is_on_floor():
		if direction == 0:
			animationPlayer.play("Idle")
		else: 
			animationPlayer.play("caminar")

	#else:
		#if velocity.y<0:
			#animationPlayer.play("salto")
		#elif velocity.y>0:
			#animationPlayer.play("caer")
